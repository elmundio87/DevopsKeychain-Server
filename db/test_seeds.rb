# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

test_public_key = "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3\nMEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUE2Q0JPNjZsZ3ZIU0x4NDA1ZnRR\nYgpQeVIvWGtFQ0VtWU84NzZReE9jbWhlcFJPZGtjSnU4TlNpYVRRMlZwSTFy\nT282aTZqUWdld2FhaWVSRDczVlQ4Cmhsbm1UaGVrNVI3VFpZL3AwbURSK3JJ\nRTNyZnh6YjdWc1Q5YTV6SmdzUkJyTzdJSVdid1dwNk5CWG1jaW5Fbk8KR2Ez\nV2p4M0Z0aitUUkZOWURZSG1IZFllc3AxNTB4blQva0VOeDBad21Qb1Mwa0NQ\ndWV2Y3BFUlpqWnd2NzlpcgpsbVR2OUc4QW81MnhxZC9sZVBtWmRjM2F2Qk1J\nbE5Qb1lId1BjbG0rejA2NW5SNVl0SC9pblcyRllVWlIxV3RlCitJK0dPQ2ds\nbFhldTlyaU9HUXFxbS9MazhoUWNGOXkwQU9TR3BNMmJKb2M1ZlYwZXVZUFpL\nMkNVdXREblRPRmkKU3dJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t\nCg==\n"


SecureContent.create(:id => 1, :name => "Password1", :content => "123456",  :environment_id => 1)
SecureContent.create(:id => 2, :name => "Password2", :content => "654321",  :environment_id => 1)
SecureContent.create(:id => 3, :name => "Password1", :content => "F0urt4", :environment_id => 2)
SecureContent.create(:id => 4, :name => "Password1", :content => "F0urt4", :environment_id => 3)


puts 'SETTING UP DEFAULT USER LOGIN'
User.create! :id => 1, :username => 'user1', :email => 'user1@keychain.com', :password => 'password', :password_confirmation => 'password', :admin => true
User.create! :id => 2, :username => 'user2', :email => 'user2@keychain.com', :password => 'password', :password_confirmation => 'password'

Environment.create :id => 1, :name => "QA", :deployment_id => 1, :public_key => test_public_key
Environment.create :id => 2, :name => "Staging", :deployment_id => 1, :public_key => test_public_key
Environment.create :id => 3, :name => "Staging", :deployment_id => 2, :public_key => test_public_key

Deployment.create :id => 1, :name => "Deployment1"
Deployment.create :id => 2, :name => "Deployment2"

Permission.create :id => 1, :user_id => 1, :deployment_id => 1
Permission.create :id => 2, :user_id => 2, :deployment_id => 2

ActiveRecord::Base.connection.tables.each do |t|
ActiveRecord::Base.connection.reset_pk_sequence!(t)

end