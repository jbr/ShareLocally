
Given /^there is a user "(.+)"$/ do |login|
  u = User.create! :login => login, :password => 'password', :password_confirmation => 'password', :email => "#{login}@example.com", :address => "san francisco"
  u.register!
end

Given /^user "(.+)" is activated$/ do |login|
  User.find_by_login(login).activate!
end

Given /^there is not a user "(.+)"$/ do |login|
  User.find_by_login(login).try :destroy
end


Given /^I am logged in as "(.+)"$/ do |login|
  u = User.create! :login => login, :password => 'password', :password_confirmation => 'password', :email => "#{login}@example.com", :address => "san francisco"
  u.register!
  u.activate!
  visit new_session_path
  fill_in 'login', :with => u.login
  fill_in 'password', :with => 'password'
  click_button 'Log in'
end