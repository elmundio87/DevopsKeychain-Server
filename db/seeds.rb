# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SecureContent.create(:id => 1, :name => "Password1", :content => "Ody553u5", :owner => 1)
SecureContent.create(:id => 2, :name => "Password2", :content => "Wibble", :owner => 1)
SecureContent.create(:id => 3, :name => "R9_Live_Webnode_password", :content => "F0urt4", :owner => 2)

puts 'SETTING UP DEFAULT USER LOGIN'
User.create! :id => 1, :email => 'elmundio1987@gmail.com', :password => 'password', :password_confirmation => 'password', :admin => true
User.create! :id => 2, :email => 'lol@lol.com', :password => 'password', :password_confirmation => 'password'
