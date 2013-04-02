# Rafter::ApiVersion

Include in your routing constraints to dictate what version the request is routed to.

## Installation

Add this line to your application's Gemfile:

    gem 'rafter_api_version'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rafter_api_version

## Usage

		Your::Application.routes.draw do
  		constraints Rafter::ApiVersion.new( :target_version => 3,
  																		    :default_version => 2 ) do
    		scope :module => :v3 do
      		resources :orders, :only => [:create, :show] do

      	end
     	end
    end

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
