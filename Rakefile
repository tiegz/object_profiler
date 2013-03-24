$: << "lib"
require 'object/profiler/profiler'
# require "bundler/gem_tasks"

task :test do
	puts "Start"
	Object::Profiler.track { 
		10.times { Hash.new }
		3.times { Class.new }
		#proc { |i| "tieg#{i}" =~ /#{i}/ }.call(rand(100))
 		2.times { String.new }
		7.times { Array.new }
	}
end
