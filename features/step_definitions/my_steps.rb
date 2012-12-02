require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /^the following users exist:$/ do |table|
  table.hashes.map do |attributes|
    @user = User.create!(attributes)
  end
end

Given /^the following articles exist:$/ do |table|
  table.hashes.map do |article|
    @my_article = Article.create!(article)
  end
end

Given /^I edit the article titled "(.*?)"$/ do |title|
  @article_id = Article.find_by_title(title).id
  visit "/admin/content/edit/#{@article_id}/"
end

Then /^I should see a field named "(.*?)"$/ do |field_name|
  field_xpath = %Q(//form/input[@name='#{field_name}'])
  if page.respond_to? :should
    page.should have_xpath(field_xpath)
  else
    assert page.has_xpath?(field_xpath)
  end
end

Given /^I am logged in to the Admin Panel as "(.*?)"$/ do |login|
  visit '/accounts/login'
  fill_in 'user_login', :with => login
  fill_in 'user_password', :with => 'password'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Then /^I should not see a field named "(.*?)"$/ do |field_name|
  field_xpath = %Q(//form/input[@name='#{field_name}'])
  if page.respond_to? :should_not
    page.should_not have_xpath(field_xpath)
  else
    assert ! page.has_xpath?(field_xpath)
  end
end

Given /^I merge the current article with the article titled "(.*?)"$/ do |title|
  article_id = Article.find_by_title(title).id
  page.fill_in 'merge_with', :with => @article_id
  page.click_on 'Merge'
  # pending # express the regexp above with the code you wish you had
end

Then /^I should see the text "(.*?)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

