class UsersController < ApplicationController

def new
	render html: "OK"
end

def list
	 @users = User.all
end

def create
end

def show
end

def update
	
	user = User.find_by(username: params[:user][:username])
	user.update(pub_key: generate_key())

end

def generate_key()
		require 'openssl'
		rsa_key = OpenSSL::PKey::RSA.new(2048)

		cipher =  OpenSSL::Cipher::Cipher.new('des3')

		private_key = rsa_key.to_pem(cipher,'password')
		public_key = rsa_key.public_key.to_pem
		key_pair = private_key + public_key

		send_data private_key, :filename => 'private.pem'
		return public_key
end


end
