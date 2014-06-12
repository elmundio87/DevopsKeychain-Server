require 'spec_helper'

  describe "the signin process", :type => :feature do
   
    it "signs me in" do
      visit '/users/sign_in'
      within("#new_user") do
        fill_in 'user_email', :with => 'user1@keychain.com'
        fill_in 'user_password', :with => 'password'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Signed in successfully.'
    end

    it "shows the admin button for an admin user" do
      visit '/users/sign_in'
      within("#new_user") do
        fill_in 'user_email', :with => 'user1@keychain.com'
        fill_in 'user_password', :with => 'password'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Admin'
    end

    it "doesn't show the admin button for a normal user" do
      visit '/users/sign_in'
      within("#new_user") do
        fill_in 'user_email', :with => 'user2@keychain.com'
        fill_in 'user_password', :with => 'password'
      end
      click_button 'Sign in'
      expect(page).to_not have_content 'Admin'
    end

    it "can log in as non-admin using Warden::Test::Helpers" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    expect(page).to_not have_content 'Admin'
    end

    it "can log in as admin using Warden::Test::Helpers" do
    user = FactoryGirl.create(:user, admin: true)
    login_as(user, :scope => :user)
    visit '/'
    expect(page).to have_content 'Admin'
    end
  
  end
