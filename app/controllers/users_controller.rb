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
	user.update(pub_key: "rofl")
	redirect_to users_path

end


end
