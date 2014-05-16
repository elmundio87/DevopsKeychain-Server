class SecureContentController < ApplicationController

def get

	user = User.find_by(email: params[:email])
	content = SecureContent.find_by(name: params[:securecontent])[:content]
	public_key = user[:pub_key]
	
	send_data public_encrypt(public_key,content)

end



def public_encrypt(key, plaintext_string)

	require 'openssl'
	require 'base64'

	public_key_file = Base64.decode64(key);
	
	public_key = OpenSSL::PKey::RSA.new(public_key_file)
	encrypted_string = Base64.encode64(public_key.public_encrypt(plaintext_string))

	return encrypted_string

end

def private_decrypt (key, encrypted_string)

	require 'openssl'
	require 'base64'

	password = 'password'
	private_key = OpenSSL::PKey::RSA.new(key,password)

	return private_key.private_decrypt(Base64.decode64(encrypted_string))

end


end
