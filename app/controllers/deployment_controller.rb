class DeploymentController < ApplicationController

def show
	 Deployment.where("id = ?", params[:id]).each do |deployment|
	 	@deployment = deployment
	 end

	 @environments = Environment.where("Deployment = ?", params[:id])
end

def new
	@users = User.all
end

def create
	@deployment = Deployment.new(name: params[:name], description: params[:description])

  	@deployment.save

	params.keys.find_all{|item| item.start_with? "permission_" }.each do |email|
		@user = User.find_by(email: email.sub(/^permission_*/,"") )
		deployment = @deployment.id
		user = @user.id
		@permission = Permission.new(user: @deployment.id, deployment: @user.id)
		@permission.save
	end

  	redirect_to "/deployments/#{@deployment.id}"

end

end
