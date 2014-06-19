require 'spec_helper'

describe User do
	it "has a valid factory" do
		expect(FactoryGirl.create(:user)).to be_valid
	end

	it "is non-admin by default" do
		expect(FactoryGirl.create(:user).admin).to be false
	end

	it "can be associated with its deployments" do
		expect(User.all[0].deployments.length).to_not be_zero
	end
end
