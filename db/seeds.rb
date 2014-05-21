# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SecureContent.create(:id => 1, :name => "Password1", :content => "Ody553u5",  :environment => 1)
SecureContent.create(:id => 2, :name => "Password2", :content => "Wibble",  :environment => 1)
SecureContent.create(:id => 3, :name => "R9_Live_Webnode_password", :content => "F0urt4", :environment => 1)

puts 'SETTING UP DEFAULT USER LOGIN'
User.create! :id => 1, :email => 'elmundio1987@gmail.com', :password => 'password', :password_confirmation => 'password', :admin => true
User.create! :id => 2, :email => 'lol@lol.com', :password => 'password', :password_confirmation => 'password'

Environment.create :id => 1, :name => "Environment1", :deployment => 1
Deployment.create :id => 1, :name => "Deployment1"

ActiveRecord::Base.connection.tables.each do |t|
ActiveRecord::Base.connection.reset_pk_sequence!(t)
end