Given /^user "(.+)" shares the following items:$/ do |user, fields|
  user = User.find_by_login(user)
  fields.rows_hash.each do |title, description|
    user.items.create! :title => title, :description => description
  end
end

When /^I search for "(.+)"$/ do |search|
  When %{I fill in "search" with "#{search}"}
  When %{I press "search-button"}
end