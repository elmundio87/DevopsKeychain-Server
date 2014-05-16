class SecureContentController < ApplicationController

def get


	require 'openssl'
	require 'base64'

	user = User.find_by(email: params[:email])
	content = SecureContent.find_by(name: params[:securecontent])[:content]

	public_key_file = Base64.decode64(user[:pub_key]);
	
	public_key = OpenSSL::PKey::RSA.new(public_key_file)
	encrypted_string = Base64.encode64(public_key.public_encrypt(content))

	send_data encrypted_string
end


end
