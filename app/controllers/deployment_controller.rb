class DeploymentController < ApplicationController

def show
	
	 @deployment = Deployment.find_by_id(params[:id])
	 @environments = @deployment.environments
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


	begin
	  	@deployment.save
	rescue ActiveRecord::RecordNotUnique => e
		flash[:alert] = "A Deployment called '#{params[:name]}' already exists."
		redirect_to :back
		return
	end

	params.keys.find_all{|item| item.start_with? "permission_" }.each do |email|
		@user = User.find_by(email: email.sub(/^permission_*/,"") )
		@permission = Permission.new(user_id: @user.id, deployment_id: @deployment.id)
		@permission.save
	end

	@permission = Permission.new(user_id: current_user.id, deployment_id: @deployment.id)
	@permission.save

  	redirect_to "/deployments/#{@deployment.id}"

end

end
