require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :email => "Email",
      :crypted_password => "Crypted Password",
      :salt => "Salt",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Crypted Password/)
    rendered.should match(/Salt/)
    rendered.should match(/false/)
  end
end
