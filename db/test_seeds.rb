# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

test_public_key = "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3\nMEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUF3WDhyc3gvczVRcURsbmgxRjVx\nMwpUWXNBcDBiajJ4MmlZcGVsNEpkM1V1ZDRGQ2hvRDlteGhSMndhTU1PaTBV\nRWhTREluN0FiZmEyT1hWTjRzanh3Ci9JU2VNNWREd0NaZ0xWV25TQUs5WHNB\nM2VGd3FZcFo5N0ZZSGRYUVpYU3dic2JVeXhiOGpaMldhNVdqajU1QjMKVjRr\nNzBGeWp4cGg2MVBFUzd5VC9jTUx4T3ZsOW5qcnZ5ek4yQlpPOEowc0NPVGg5\nakVwT210VFh6TGZRMW96QwpwQks4NG1wanZhUHpMcGdlVzlDanVyQkhRdHhW\nUzYzRlhIU2RYZXgzT1ZhM0hwRzREM2srdEZDY3lyZGhqbHFYCkFVVVpMNkRK\nTHl1aERTRXZtZVJYOFQ0dE8wU3ZudHZUNWlFM2JkY05hRFU5SDFMM1NrbkJS\nRXVvYmZkdTJNaHgKWFFJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t\nCg==\n"


SecureContent.create(:id => 1, :name => "Domain Password", :content => "Ody553u5",  :environment_id => 1)
SecureContent.create(:id => 2, :name => "Local Admin", :content => "Wibble",  :environment_id => 1)
SecureContent.create(:id => 3, :name => "Domain Password", :content => "F0urt4", :environment_id => 2)
SecureContent.create(:id => 4, :name => "Hyper-V Password", :content => "F0urt4", :environment_id => 3)


puts 'SETTING UP DEFAULT USER LOGIN'
User.create! :id => 1, :email => 'user1@keychain.com', :password => 'password', :password_confirmation => 'password', :admin => true
User.create! :id => 2, :email => 'user2@keychain.com', :password => 'password', :password_confirmation => 'password'

Environment.create :id => 1, :name => "QA", :deployment_id => 1, :public_key => test_public_key
Environment.create :id => 2, :name => "Staging", :deployment_id => 1, :public_key => test_public_key
Environment.create :id => 3, :name => "Staging", :deployment_id => 2, :public_key => test_public_key
Deployment.create :id => 1, :name => "R9 Web"
Deployment.create :id => 2, :name => "Tradesimple Webnode"

Permission.create :id => 1, :user_id => 1, :deployment_id => 1
Permission.create :id => 2, :user_id => 2, :deployment_id => 2

ActiveRecord::Base.connection.tables.each do |t|
ActiveRecord::Base.connection.reset_pk_sequence!(t)

end