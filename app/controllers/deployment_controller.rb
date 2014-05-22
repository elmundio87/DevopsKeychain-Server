class DeploymentController < ApplicationController

def show
	 @environments = Environment.all
end

end
