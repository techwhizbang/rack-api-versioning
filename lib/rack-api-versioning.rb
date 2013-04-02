require 'rubygems'

Dir.glob(File.expand_path(File.dirname(__FILE__) + "/rack_api_versioning/*.rb")) { |file| require file }
