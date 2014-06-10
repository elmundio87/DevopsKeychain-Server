class EnvironmentController < ApplicationController

def update
	require 'base64'

	key_pair = generate_keys()

	environment = Environment.find_by(id: params[:environment][:id])
	deployment = params[:environment][:deployment_id]
	environment.update(public_key: Base64.encode64(key_pair[0]))

	filename = "#{deployment}-#{environment.name}.pem"

	send_data key_pair[1], :filename => filename
end


def generate_keys()
	require 'openssl'
	rsa_key = OpenSSL::PKey::RSA.new(2048)

	cipher =  OpenSSL::Cipher::Cipher.new('des3')

	private_key = rsa_key.to_pem(cipher,'password')
	public_key = rsa_key.public_key.to_pem
	key_pair = [public_key,private_key]
	
	return key_pair
end


end
