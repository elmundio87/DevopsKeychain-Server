class DeploymentController < ApplicationController

def show
	 Deployment.where("id = ?", params[:id]).each do |deployment|
	 	@deploymentName = deployment.name
	 end
	 @environments = Environment.where("Deployment = ?", params[:id])
end

def new
	render text: "OK"
end

end
