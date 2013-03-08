require 'spec_helper'

describe "advertisments/index" do
  before(:each) do
    assign(:advertisments, [
      stub_model(Advertisment,
        :img_url => "Img Url",
        :link_url => "Link Url",
        :active => false
      ),
      stub_model(Advertisment,
        :img_url => "Img Url",
        :link_url => "Link Url",
        :active => false
      )
    ])
  end

  it "renders a list of advertisments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Img Url".to_s, :count => 2
    assert_select "tr>td", :text => "Link Url".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
