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
	
	user = User.find_by(name: params[:user])
	user.update(pub_key: "rofl")

end


end
