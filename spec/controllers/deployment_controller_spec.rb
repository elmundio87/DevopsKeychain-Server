require 'spec_helper'

describe DeploymentController, :type => :controller do

	before(:each) do
		sign_in User.all[0]
	end

	describe "GET index" do
		it "has a 200 status code" do
			get :show, id: 1
			expect(response.code).to match "200"
		end

		it "redirects to root if the deployment does not exist" do
			get :show, id: 0
			expect(response).to redirect_to "/"
		end

		it "shows 403 error if you don't have permission to view it" do
			get :show, id: 2
			expect(response.code).to match "403"
		end

	end

end
