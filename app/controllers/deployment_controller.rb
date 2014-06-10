class DeploymentController < ApplicationController

def show
	 Deployment.where("id = ?", params[:id]).each do |deployment|
	 	@deployment = deployment
	 end

	 @environments = Environment.where("Deployment = ?", params[:id])

	 @permission = Permission.find_by_user_id_and_deployment_id(current_user.id, @deployment.id )

	 if(@permission == nil)
	 	flash[:alert] = "You do not have permission to access that resource"
	 	redirect_to "/"
	 end
	 

end

def new
	@users = User.all
end

def create
	@deployment = Deployment.new(name: params[:name], description: params[:description])

  	@deployment.save

	params.keys.find_all{|item| item.start_with? "permission_" }.each do |email|
		@user = User.find_by(email: email.sub(/^permission_*/,"") )
		@permission = Permission.new(user_id: @user.id, deployment_id: @deployment.id)
		@permission.save
	end

  	redirect_to "/deployments/#{@deployment.id}"

end

end
