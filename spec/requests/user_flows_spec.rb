# encoding: utf-8
require 'spec_helper'


describe "UserFlows" do
  let(:registed_user) { FactoryGirl.create(:registed_user) }

  before(:all) do
    #...registeruser...
    #User.first.activation_state
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
      fill_in 'username', :with => registed_user.email
      fill_in 'password', :with => registed_user.password
      click_on "Login"
      sleep 5
    end
  end  
end
