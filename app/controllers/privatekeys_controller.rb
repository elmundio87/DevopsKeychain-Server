class PrivatekeysController < ApplicationController

	def new
		render html: "privatekeys.html"
	end

	def create
		require 'openssl'
		rsa_key = OpenSSL::PKey::RSA.new(2048)

		cipher =  OpenSSL::Cipher::Cipher.new('des3')

		private_key = rsa_key.to_pem(cipher,'password')
		public_key = rsa_key.public_key.to_pem
		key_pair = private_key + public_key

		send_data private_key, :filename => 'private.pem'
		
	end

end
