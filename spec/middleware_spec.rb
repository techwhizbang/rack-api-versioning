require 'spec_helper'

describe RackApiVersioning::Middleware do

	include Rack::Test::Methods

	def app
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
	end

	context "when the request hits '/'" do

		context "when the API versioning header is included" do

			it 'responds successfully to the request' do
				get "/", {}, {'Accept' => "application/vnd.awesome-app-v2+json"}
				last_response.ok?.should be_true
			end

		end

		context "when the API versioning header is excluded" do

			it 'responds with a 400 status code' do
				get "/", {}, {}
				last_response.status.should == 400
			end

			it 'responds with a plain text error message' do
				get "/", {}, {}
				last_response.body.should == "The request did not contain an appropriate API version header."
			end

		end

		context "when the API versioning header is wrong" do

			it 'responds with a 400 status code' do
				get "/", {}, {'Accept' => "application/vnd.bad-header-v1+xml"}
				last_response.status.should == 400
			end

			it 'responds with a plain text error message' do
				get "/", {}, {'Accept' => "application/vnd.bad-header-v1+xml"}
				last_response.body.should == "The request did not contain an appropriate API version header."
			end

		end

		context "when the target version is wrong" do

			it 'responds with a 400 status code' do
				get "/", {}, {'Accept' => "application/vnd.awesome-app-v4+json"}
				last_response.status.should == 400
			end

		end

	end

	context "when the request hits '/new-improved-api" do

		context "when the API versioning header is included" do

			it 'responds successfully to the request' do
				get "/new-improved-api", {}, {'Accept' => "application/vnd.awesome-app-v3+json"}
				last_response.ok?.should be_true
			end

		end

	end

end