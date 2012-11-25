Feature: Merge Articles
  As a blog administrator
  In order to manage and present content on the same topic
  I want to be able to merge articles by different authors on my blog

  Background:
    Given the following articles exist:
      | article_title      | article_body                   |
      | Foobar             | Lorem Ipsum                    |
      | Gettysburg Address | Four Score and Seven Years Ago |

    And the following users exist:
      | login  | password   | profile            |
      | admin1 | admin-pass | Typo administrator |
      | user1  | user1-pass | Contributor        |
      | user2  | user2-pass | Contributor        |

    And the following comments exist:
      | article_title      | comment_author | body                 |
      | Foobar             | user1          | foobar comment 1     |
      | Foobar             | user2          | foobar comment 2     |
      | Gettysburg Address | user1          | gettysburg comment 1 |
      | Gettysburg Address | user2          | gettysburg comment 2 |

  Scenario: an Admin can merge articles
    Given I am logged in to the Admin Panel as "admin1"
    And I go to the Edit Page for the article titled "Foobar"
    Then I should see a field named "merge_with"

  Scenario: a non-Admin can not merge articles
    Given I am logged in to the Admin Panel as "user1"
    And I go to the Edit Page for the article titled "Foobar"
    Then I should not see a field named "merge_with"

  Scenario: a merged article should contain the text of both previous articles
    Given I am logged in to the Admin Panel as "admin1"
    And I go to the Edit Page for the article titled "Foobar"
    And I fill in "merge_with" with the id of the article titled "Gettysburg Address"
    And I press "Publish"
    And I go to the Show Page for the article titled "Foobar"
    Then I should see the text "Lorem Ipsum
    And I should see the text "Four Score and Seven Years Ago"

