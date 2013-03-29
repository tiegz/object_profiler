# Object::Profiler

Track how many Ruby objects your code is creating. In the style of GC::Profiler and 
inspired by memprof.

## Requirements

1. A platform that supports DTrace (Solaris, OSX, etc)
2. root access (required by DTrace)

## Installation

Add this line to your application's Gemfile:

    gem 'object_profiler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install object_profiler

## Usage

    Object::Profiler.track { 
      require 'rdoc/rdoc'
    }
    # => Amount File:Line:Class
    # =>      1 /.../2.0.0/json/common.rb:67:JSON::Ext::Generator::State
    # =>      1 /.../2.0.0/json/common.rb:68:JSON::Ext::Generator::State
    # =>      1 /.../2.0.0/json/common.rb:75:JSON::Ext::Generator::State
    # =>      1 /.../2.0.0/rdoc/generator/markup.rb:65:Range
    # =>      1 /.../2.0.0/rdoc/text.rb:42:Hash
    # =>      1 /.../gems/2.0.0/gems/bundler-1.3.4/lib/bundler/rubygems_integration.rb:200:Gem::Dependency
    # =>      1 /.../gems/2.0.0/gems/bundler-1.3.4/lib/bundler/rubygems_integration.rb:207:Gem::LoadError
    # =>      1 /.../gems/2.0.0/gems/bundler-1.3.4/lib/bundler/shared_helpers.rb:23:Pathname
    # =>      1 /.../gems/2.0.0/gems/bundler-1.3.4/lib/bundler/shared_helpers.rb:23:String
    # =>      1 /.../site_ruby/2.0.0/rubygems/requirement.rb:52:Gem::Requirement
    # =>      2 /.../gems/2.0.0/gems/bundler-1.3.4/lib/bundler.rb:177:Pathname
    # =>      2 /.../gems/2.0.0/gems/bundler-1.3.4/lib/bundler.rb:177:String
    # =>      3 /.../gems/2.0.0/gems/bundler-1.3.4/lib/bundler/rubygems_ext.rb:23:Pathname
    # =>      5 /.../gems/2.0.0/gems/bundler-1.3.4/lib/bundler/rubygems_ext.rb:23:String
    # =>      6 /.../2.0.0/rdoc/class_module.rb:5:Range
    # =>      6 /.../2.0.0/rdoc/markdown/literals_1_9.rb:359:RDoc::Markdown::Literals::RuleInfo
    # =>    240 /.../2.0.0/rdoc/markdown.rb:508:RDoc::Markdown::RuleInfo
    # =>    274 Total

## Usage - Rails Middleware

  Add to your app initializers, ie `config/initializers/object_profiler.rb`:

    require 'object/profiler/middleware'
    My::Application.config.middleware.use(::Object::Profiler::Middleware, {:output => 'object_profiler.log'})

  Run the server and tail the log:

    sudo rails s

## Useful DTrace links

1. https://wikis.oracle.com/display/DTrace/Documentation

