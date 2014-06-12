FactoryGirl.define do 
	factory :user do |f| 
		f.username "name"
		f.email "name@domain.com"  
		f.password "password"
	end 
end