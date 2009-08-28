Feature: Item search
  In order to find the item that I want
  As a signed up and logged in user
  I want to be able to search
  
  Scenario: Searching for an item that exists
    Given there is a user "example"
    And user "example" is activated
    And there is a user "sharer"
    And user "sharer" shares the following items:
      | old blanket | comfortable |
      | pillow  | description |
    When I log in as "example"
    And I search for "blanket"
    Then I should see "comfortable"

