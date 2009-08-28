
Given /^there is a user "(.+)"$/ do |login|
  u = User.create! :login => login, :password => 'password', :password_confirmation => 'password', :email => "#{login}@example.com", :address => "san francisco"
  u.register!
end

Given /^user "(.+)" is activated$/ do |login|
  User.find_by_login(login).activate!
end