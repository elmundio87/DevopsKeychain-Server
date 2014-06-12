# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
User.create! :id => 1, :username => 'admin' , :email => 'admin@elmundio.net', :password => 'password', :password_confirmation => 'password', :admin => true
User.create! :id => 2, :username => 'dummy' , :email => 'dummy@elmundio.net', :password => 'password', :password_confirmation => 'password'


ActiveRecord::Base.connection.tables.each do |t|
ActiveRecord::Base.connection.reset_pk_sequence!(t)

end