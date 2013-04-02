# RackApiVersioning

Version your Rack based API's using headers either through middleware or routing constraints.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-api-versioning'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-api-versioning

## Usage in Rails
```ruby
    Your::Application.routes.draw do
      constraints RackApiVersioning::Constraint.new( :target_version => 3,
                                                     :default_version => 2,
                                                     :app_name => "awesome-app",
                                                     :media_type => "json" ) do
    		scope :module => :v3 do
      		resources :orders, :only => [:create, :show] do

      	end
     	end
    end
```
## Usage in any Rack app
```ruby
    Rack::Builder.new do
      
      map '/' do        
        use RackApiVersioning::Middleware, 
          :app_name => "awesome-app",
          :default_version => 1,
          :target_version => 2

        run lambda { |env| 
          [200, {"Content-Type" => "text/html"}, "Testing RackApiVersioning"] 
        }
      end

      map "/new-improved-api" do
        use RackApiVersioning::Middleware, 
          :app_name => "awesome-app",
          :default_version => 2,
          :target_version => 3

        run lambda { |env| 
          [200, {"Content-Type" => "text/html"}, "Testing RackApiVersioning"] 
        } 
      end
      
    end
```
