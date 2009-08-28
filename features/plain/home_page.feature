Feature: User home page
  In order to provide a dashboard view
  As a signed up and logged in user
  I want to be see my home page when I log in
  
  Scenario: Logged in user goes to their home page
    Given there is a user "example"
    And user "example" is activated
    When I log in as "example"
    When I go to the homepage
    Then I should be on example's home page