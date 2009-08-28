Feature: Log In
  In order to get access to my records
  As a signed up user
  I want to be able to log in
  
  Scenario: Successful log in
    Given there is a user "example"
    And user "example" is activated
    When I go to the homepage
    And I follow "log-in-link"
    And I fill in "login" with "example"
    And I fill in "password" with "password"
    And I press "log-in-button"
    Then I should see "Logged in successfully"
    And I should see "example"
    And I should see "Log out"

  Scenario: Unsuccessful log in
    Given there is a user "joe"
    When I go to log in
    And I fill in "login" with "joe"
    And I fill in "password" with "not my password"
    And I press "log-in-button"
    Then I should see "Couldn't log you in as 'joe'"
