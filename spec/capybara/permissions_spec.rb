 require 'spec_helper'


describe "permissions", :type => :feature do

    it "Only shows the deployments that user1 has access to" do
    user = User.find_by_email("user1@keychain.com")
    login_as(user, :scope => :user)
    visit '/'
    expect(page).to have_content 'R9 Web'
    expect(page).to_not have_content 'Tradesimple'
    end

    it "Only shows the deployments that user2 has access to" do
    user = User.find_by_email("user2@keychain.com")
    login_as(user, :scope => :user)
    visit '/'
    expect(page).to_not have_content 'R9 Web'
    expect(page).to have_content 'Tradesimple'
    end

end