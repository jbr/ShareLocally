Feature: Sign Up
  In order to distinguish my data from other users', provide privacy, and register my email address
  As a new user
  I want to be able to sign up
  
  Scenario: Successful sign up
    Given there is not a user "test"
    When I go to the homepage
    And I follow "sign-up-link"
    And I fill in "login" with "test"
    And I fill in "email" with "test@example.com"
    And I fill in "password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I fill in "address" with "San Francisco"
    And I press "sign-up-button"
    Then I should see "Thanks for signing up!"
    And I should see "We just sent an email to test@example.com"
    And I should be on the about page

  Scenario: Duplicate email
    Given there is a user "test"
    When I go to sign up
    And I fill in "login" with "test_user"
    And I fill in "email" with "test@example.com"
    And I fill in "password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I fill in "address" with "San Francisco"
    And I press "sign-up-button"
    Then I should see "Email has already been taken"
  
  Scenario: Confirmation password doesn't match
    When I go to sign up
    And I fill in "login" with "test"
    And I fill in "email" with "test@example.com"
    And I fill in "password" with "password"
    And I fill in "user_password_confirmation" with "not the same password"
    And I fill in "address" with "San Francisco"
    And I press "sign-up-button"
    Then I should see "Password doesn't match confirmation"

  Scenario: Email is not a real email address
    When I go to sign up
    And I fill in "login" with "test"
    And I fill in "email" with "test at example.com"
    And I fill in "password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I fill in "address" with "San Francisco"
    And I press "sign-up-button"
    Then I should see "Email should look like an email address"
