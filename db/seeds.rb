# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SecureContent.create(:id => 1, :name => "Domain Password", :content => "Ody553u5",  :environment_id => 1)
SecureContent.create(:id => 2, :name => "Local Admin", :content => "Wibble",  :environment_id => 1)
SecureContent.create(:id => 3, :name => "Domain Password", :content => "F0urt4", :environment_id => 2)
SecureContent.create(:id => 4, :name => "Hyper-V Password", :content => "F0urt4", :environment_id => 3)


puts 'SETTING UP DEFAULT USER LOGIN'
User.create! :id => 1, :email => 'elmundio1987@gmail.com', :password => 'password', :password_confirmation => 'password', :admin => true
User.create! :id => 2, :email => 'lol@lol.com', :password => 'password', :password_confirmation => 'password'

Environment.create :id => 1, :name => "QA", :deployment_id => 1
Environment.create :id => 2, :name => "Staging", :deployment_id => 1
Environment.create :id => 3, :name => "Staging", :deployment_id => 2
Deployment.create :id => 1, :name => "R9 Web"
Deployment.create :id => 2, :name => "Tradesimple Webnode"

Permission.create :id => 1, :user_id => 1, :deployment_id => 1
Permission.create :id => 2, :user_id => 2, :deployment_id => 2

ActiveRecord::Base.connection.tables.each do |t|
ActiveRecord::Base.connection.reset_pk_sequence!(t)

end