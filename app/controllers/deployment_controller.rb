class DeploymentController < ApplicationController

	def show

		@deployment = Deployment.find_by_id(params[:id])

		if(@deployment.nil?)
			flash[:alert] = "That deployment does not exist"
			redirect_to "/"
			return
		end

		@permission = Permission.find_by_user_id_and_deployment_id(current_user.id, @deployment.id )

		if(@permission.nil?)
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end

	end

	def new
		@users = User.all
	end

	def create

		if(params[:name].strip() === "")
			flash[:alert] = "A deployment name cannot be blank"
			redirect_to :back
			return
		end

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
			Permission.create(:user_id => @user.id, :deployment_id => @deployment.id)
		end

		Permission.create(:user_id => current_user.id, :deployment_id => @deployment.id)

		redirect_to "/deployments/#{@deployment.id}"

	end

end
