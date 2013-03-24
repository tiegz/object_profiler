# Object::Profiler

TODO: Write a gem description

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

## Usage (Rails)

  Add to your `config/application.rb`:

    require 'object/profiler/middleware'
    config.middleware.use(::Object::Profiler::Middleware)

  Run the server and tail the output:

    sudo rails s

## Middleware

    require 'object/profiler/middleware'
    config.middlewares.use(Object::Profiler::Middleware)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Useful DTrace links

1. https://wikis.oracle.com/display/DTrace/Documentation