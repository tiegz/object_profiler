if not system("dtrace -l -i :::jabberwocky")
	raise "DTrace not responding. Are you running with sudo?"
end

require 'tempfile'

class Object
	class Profiler
		class << self
		  def track
		  	raise "Object::Profiler.track requires a block." unless block_given?

		  	start
		  	result = yield
		  	stop
		  	report

		  	return result
		  end

		  def start
		  	raise "Already tracking ruby process #@pid!" if @pid

		    @tmpfile = Tempfile.new("object::profiler")
		    @results = []
		    probe = File.join(__dir__, 'probes', 'object_create.d')
		    @pid = Process.spawn "dtrace -s #{probe} -p #{$$} -o #{@tmpfile.path}"

		    # Better way to wait for dtrace to work?
		    sleep 1
		  end

		  def stop
		    Process.kill("SIGINT", @pid)
		    Process.wait
		  	@pid = nil
		  end

		  def report
		    puts "\n\nObject::Profiler Report (#{@tmpfile.path}):"
		    @tmpfile.rewind
		    
		    # TODO: This is only to reverse the order of line & count... necessary?
		    results = []
		    @tmpfile.read.strip.lines.each do |line|
		    	file_line_type, amount = line.split(" ")
		    	@results << [amount.to_i, file_line_type]
		    end
		    puts @results.map { |r| "%8d %s" % r }.join("\n")
		  	
		  	@tmpfile, @results = nil
		  end
		end
	end
end
