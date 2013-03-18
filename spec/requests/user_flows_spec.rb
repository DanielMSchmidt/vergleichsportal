# encoding: utf-8
require 'spec_helper'

def registerAndActivateUser(user_attributes)
  visit root_path
  click_link "Anmelden / Registrieren"
  sleep 2
  click_on "Registrieren!"
  sleep 2
  fill_in 'user[email]', :with => user_attributes[:email]
  fill_in 'user[password]', :with => user_attributes[:password]
  fill_in 'user[password_confirmation]', :with => user_attributes[:password]
  sleep 1
  puts User.all
  user = User.last
  puts user.class
  puts user
end
  

describe "UserFlows" do
  @user_attr = FactoryGirl.attributes_for(:registered_user)

  before(:each) do
    @user_attr = FactoryGirl.attributes_for(:registered_user)
    #puts @user_attr
    #puts @user_attr.class
    registerAndActivateUser(@user_attr)
  end

  describe "Login without E-Mail Adress and PW", :js => true do
    it "should give an error, when you login without E-Mail and PW" do
      visit root_path
      click_link "Anmelden / Registrieren"
      sleep 1
      click_on "Login"
      page.driver.browser.switch_to.alert.accept     
    end
  end

  describe "Login with unknown E-Mail adress and PW", :js => true do
    it "should give an error, when you try to login" do
      visit root_path
      click_link "Anmelden / Registrieren"
      sleep 1
      fill_in 'username', :with => 'user@example.de'
      fill_in 'password', :with => 'password'
      click_on "Login"
      page.driver.browser.switch_to.alert.accept 
    end
  end

  describe "Login with known E-Mail adress and PW", :js => true do
    it "should login" do
      visit root_path
      click_link "Anmelden / Registrieren"
      sleep 1
      puts "hello"
      fill_in 'username', :with => registered_user.email
      fill_in 'password', :with => registered_user.password
      click_on "Login"
      sleep 5
    end
  end  
end
