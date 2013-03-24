raise "Object::Profiler must be used with Ruby 2.0+" if RUBY_VERSION < "2"

require 'object/profiler/version'
require 'tempfile'
require 'pp'

class Object
	class Profiler
		class << self

		  def track
		  	start
		  	yield
		  	stop
		  	report
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
		    puts "\n\n\nReport (#{@tmpfile.path}):"
		    @tmpfile.rewind
		    @tmpfile.read.split('-----').last.strip.lines.each do |line|
		    	file_line_type, amount = line.split("=")
		    	@results << [amount, file_line_type]
		    end
		    @results = @results.sort_by { |line| line[0].to_i }.reverse
		    @results.each do |result|
		    	puts "%-10d %s" % result
		    end
		  	@tmpfile  = nil
		  end
		end
	end
end
