##
# Use pure Rack middleware to handle your API versioning

module RackApiVersioning

	class Middleware

		##
		# Valid options include the same options the RackApiVersioning::Constraint
		# class uses. Specifically:
		#
		# 	:target_version => This is the API version you want to use, 
		# 										 when left unspecified it defaults to 1.
		#
		# 	:default_version => This is the API version to failover to, 
		# 											when left unspecified it defaults to 1.
		#
		#   :app_name => The app name that should be included in the 'Accept' 
		# 							 header, when left unspecified it defaults to "api".
		#
		# 	:media_type => The desired media type the API should respond with, 
		# 								when left unspecified it defaults to "*".
		#
		def initialize(app, options = {})
			@app = app
			@api_version_constraint = Constraint.new(options)			
		end

		def call(env)
			if @api_version_constraint.matches?(env)
				@app.call(env)
			else
				api_version_error
			end
		end

		##
		# Subclass and override this method if you'd like an alternate behavior.
		def api_version_error
			body_text = "The request did not contain an appropriate API version header."
			[400, {'Content-Type' => 'text/plain; charset=utf-8',
           	 'Content-Length' => body_text.size.to_s}, [body_text]]
		end

	end

end