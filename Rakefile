$: << "lib"
require 'object/profiler/profiler'
g
task :test do
  Object::Profiler.track { 
    10.times { Hash.new }
    3.times { Class.new }
    2.times { String.new }
    7.times { Array.new }
  }
end
