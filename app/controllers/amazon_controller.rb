class AmazonController < ApplicationController

	def sign_key
	response = Amazon.get_s3_upload_key
	render json: response, status: 200
	end
end
