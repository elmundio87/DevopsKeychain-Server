require 'spec_helper'

describe Environment, :type => :model do
	
	it "has a valid factory" do
		expect(FactoryGirl.create(:environment)).to be_valid
	end

	it "is invalid without a name" do
		expect(FactoryGirl.build(:environment, name: "")).to_not be_valid
		expect(FactoryGirl.build(:environment, name: nil)).to_not be_valid
	end

	it "is invalid without a deployment" do
		expect(FactoryGirl.build(:environment, deployment_id: nil)).to_not be_valid
	end
end
