require 'spec_helper'

describe "carts/index" do
  before(:each) do
    assign(:carts, [
      stub_model(Cart,
        :user_id => 1
      ),
      stub_model(Cart,
        :user_id => 1
      )
    ])
  end

  it "renders a list of carts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
