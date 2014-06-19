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

		
		if(user_signed_in?)
	    @passwords = SecureContent.all #where("owner = ?", current_user[:id])

	end


end

def update
	
	require 'base64'

	key_pair = generate_keys()

	user = User.find_by(email: params[:user][:email])
	user.update(pub_key: Base64.encode64(key_pair[0]))

	send_data key_pair[1], :filename => 'private.pem'

end



end