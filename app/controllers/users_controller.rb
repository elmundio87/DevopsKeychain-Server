class UsersController < ApplicationController
before_filter :authenticate_user!
def new
	render html: "OK"
end

def list
	 @users = User.all
end

def create
end

def show

	
	if(user_signed_in?)
	    @passwords = SecureContent.where("owner = ?", current_user[:id])

	end


end

def update
	
	require 'base64'

	key_pair = generate_keys()

	user = User.find_by(email: params[:user][:email])
	user.update(pub_key: Base64.encode64(key_pair[0]))

	send_data key_pair[1], :filename => 'private.pem'

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
