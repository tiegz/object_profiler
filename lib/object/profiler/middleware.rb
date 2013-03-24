# require File.expand_path('../../profiler.rb', __FILE__)

class Object
	class Profiler
  	class Middleware
	    def call(env)
				Object::Profiler.track { 
	      	@app.call(env)
	      }
	    end
	  end
  end
end