require 'spec_helper'

describe Deployment, :type => :model do

	it "has a valid factory" do
		expect(FactoryGirl.create(:deployment)).to be_valid
	end

	it "is invalid without a name" do
		expect(FactoryGirl.build(:deployment, name: "")).to_not be_valid
		expect(FactoryGirl.build(:deployment, name: nil)).to_not be_valid
	end

	it "returns its list of environments" do
		expect(Deployment.all[0].environments.length).to_not be_equal(0)
	end

end
