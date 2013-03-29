if not system("dtrace -l -i :::jabberwocky")
  raise "DTrace not responding. Are you running with sudo?"
end

require 'tempfile'

class Object
  class Profiler
    class << self
      def track(output)
        raise "Object::Profiler.track requires a block." unless block_given?

        enable
        result = yield
        disable
        report(output)

        return result
      end

      def enable
        return if enabled?

        @tmpfile = Tempfile.new("object::profiler")
        @report = nil
        probe = File.join(__dir__, 'probes', 'object_create.d')
        @pid = Process.spawn "dtrace -q -s #{probe} -p #{$$} -o #{@tmpfile.path}"

        # Better way to wait for dtrace to work?
        sleep 1
      end

      def enabled?
        !!@pid
      end

      def disable
        return unless enabled?

        Process.kill("SIGINT", @pid)
        Process.wait
        @pid = nil
      end

      def report(io)
        if !@report
          @tmpfile.rewind
        
          # TODO: Could this be done in the provider instead?
          results = []
          @tmpfile.read.strip.lines.each do |line|
            file_line_type, amount = line.split(" ")
            results << [amount.to_i, file_line_type]
          end
          @report = results.map { |r| "%10d %s" % r }
          @report << "%10d %s" % [results.map(&:first).inject(0, &:+), "Total"]
          @report.unshift "\n%10s %s" % ["Amount", "File:Line:Class"]

        end
        io ||= STDOUT
        io.puts @report.join("\n")
      end
    end
  end
end
