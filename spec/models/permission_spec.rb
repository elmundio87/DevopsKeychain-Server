require 'spec_helper'

describe Permission do
 
	it "has a valid factory" do
		expect(FactoryGirl.build(:permission)).to be_valid
	end


end
