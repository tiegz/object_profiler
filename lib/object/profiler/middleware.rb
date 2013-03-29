require ::File.expand_path('../profiler.rb',  __FILE__)

class Object
  class Profiler
    class Middleware
      def initialize(app, options={})
        @app    = app
        @output = options[:output] ? File.open(options[:output], 'w+') : STDOUT

      end

      def call(env)
        Object::Profiler.track(@output) { 
          @app.call(env)
        }
      end
    end
  end
end