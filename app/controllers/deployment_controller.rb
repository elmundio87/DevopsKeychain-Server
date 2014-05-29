class DeploymentController < ApplicationController

def show
	 Deployment.where("id = ?", params[:id]).each do |deployment|
	 	@deploymentName = deployment.name
	 end
	 @environments = Environment.where("Deployment = ?", params[:id])
end

def new
	@users = User.all
end

def create
	@deployment = Deployment.new(name: params[:name])
 
  	@deployment.save
  	redirect_to "/deployments/#{@deployment.id}"
end

end
