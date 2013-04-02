require 'spec_helper'

describe RackApiVersioning::Constraint do
	
	describe "#match?" do

		context "when a versioned API request header is provided" do

				subject(:api_version) { 
					RackApiVersioning::Constraint.new(	:default_version => 1,
																							:target_version => 2,
																							:app_name => "sweet-api" ) }

				let(:request_with_good_header) do
					stub('request', :headers => {"Accept" => "application/vnd.sweet-api-v2+json"})
				end

				let(:request_with_bad_header) do
					stub('request', :headers => {"Accept" => "application/vnd.wrong-api-v2.json"})
				end

				it 'returns true when the format matches properly' do
					api_version.matches?(request_with_good_header).should be_true
				end

				it 'returns false if the format is incorrect' do
					api_version.matches?(request_with_bad_header).should be_false
				end

			end

		end

		context "when a versioned API request is missing" do

				let(:request_with_no_header) { stub('request', :headers => {}) }

				subject(:api_versions_same) { 
					RackApiVersioning::Constraint.new(	:default_version => 5000,
																							:target_version => 5000 ) }

				subject(:api_versions_diff) { 
					RackApiVersioning::Constraint.new(	:default_version => 4999,
																							:target_version => 5000 ) }
				

				it 'returns true if the default and target version are the same' do
					api_versions_same.matches?(request_with_no_header).should be_true
				end

				it 'returns false if the default and target versions are different' do
					api_versions_diff.matches?(request_with_no_header).should be_false
				end

		end

end