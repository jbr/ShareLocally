Feature: Item sharing
  In order to make sharelocally valuable
  As a signed up and logged in user
  I want to be able to share items
  
  Scenario: Adding a new item
    Given there is a user "example"
    And user "example" is activated
    When I log in as "example"
    And I follow "Share some stuff!"
    And I fill in "item_title" with "my item"
    And I press "Save"
    And I go to the homepage
    Then I should see "my item"
