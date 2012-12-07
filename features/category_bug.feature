Feature: Add or Edit Categories
  As a blog administrator
  In order to categorize content
  I want to be able to add or edit categories

  Scenario: an Admin can add or edit categories
    Given the blog is set up
    And I am logged into the admin panel
    Then I can open the Categories page
