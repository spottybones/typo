Feature: Merge Articles
  As a blog administrator
  In order to manage and present content on the same topic
  I want to be able to merge articles by different authors on my blog

  Background:
    Given the blog is set up

    And the following users exist:
      | login  | password   | email             | profile_id | name     | state  |
      | user1  | password   | user1@example.com | 2          | user one | active |
      | user2  | password   | user2@example.com | 2          | user two | active |

    Given the following articles exist:
      | title              | body                           | author |
      | Foobar             | Lorem Ipsum                    | user1 |
      | Gettysburg Address | Four Score and Seven Years Ago | user2 |

    Given the following comments exist:
      | article_title      | body                       | author   |
      | Foobar             | Foobar Comment             | user one |
      | Gettysburg Address | Gettysburg Address Comment | user two |

  Scenario: an Admin can merge articles
    Given I am logged into the admin panel
    And I edit the article titled "Foobar"
    Then I should see a field named "merge_with"

  Scenario: a non-Admin can not merge articles
    Given I am logged in to the Admin Panel as "user1"
    And I edit the article titled "Gettysburg Address"
    Then I should not see a field named "merge_with"

  Scenario: a merged article should contain the text of both previous articles
    Given I am logged into the admin panel
    And I edit the article titled "Foobar"
    And I merge the current article with the article titled "Gettysburg Address"
    Then I should see the text "Lorem Ipsum"
    And I should see the text "Four Score and Seven Years Ago"
    And I should see the text "Foobar Comment"
    And I should see the text "Gettysburg Address Comment"

