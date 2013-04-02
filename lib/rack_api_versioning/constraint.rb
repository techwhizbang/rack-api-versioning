##
# Use an instance of RackApiVersioning::Constraint in a Rackup file or in Rails routing.

module RackApiVersioning
	class Constraint
		##
		# There are four options:
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
		def initialize(options = {})
		  @target_version = options[:target_version] || 1
		  @default_version = options[:default_version] || 1
		  @app_name = options[:app_name] || "api"
		  @media_type = options[:media_type] || "*"
		end

		##
		# Valid versioned API headers look like this:
		# Accept: application/vnd.api-v1+json
		# If no API version header is provided the default API version will be used.
		def matches?(request)
		  versioned_accept_header?(request) || default_version?(request)
		end

		private

		def versioned_accept_header?(request)
			accept = accept_header(request)
			accept && accept.match(/application\/vnd\.#{@app_name}-v#{@target_version}\+#{@media_type}/)
		end

		def unversioned_accept_header?(request)
		  accept = accept_header(request)
		  (accept.nil? || accept == "" ) || accept.match(/application\/vnd\.#{@app_name}/).nil?
		end

		def accept_header(request)
			if request.respond_to?(:headers)
		  	# support for Rails ActionDispatch::Request
				request.headers['Accept']

		  else
		  	# support for the Rack env request
		  	request['Accept']
		  end
		end

		def default_version?(request)
		  @target_version == @default_version && unversioned_accept_header?(request)
		end

	end
end
