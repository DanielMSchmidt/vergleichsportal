require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :email => "Email",
        :crypted_password => "Crypted Password",
        :salt => "Salt",
        :active => false
      ),
      stub_model(User,
        :email => "Email",
        :crypted_password => "Crypted Password",
        :salt => "Salt",
        :active => false
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Crypted Password".to_s, :count => 2
    assert_select "tr>td", :text => "Salt".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
