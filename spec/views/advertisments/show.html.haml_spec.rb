require 'spec_helper'

describe "advertisments/show" do
  before(:each) do
    @advertisment = assign(:advertisment, stub_model(Advertisment,
      :img_url => "Img Url",
      :link_url => "Link Url",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Img Url/)
    rendered.should match(/Link Url/)
    rendered.should match(/false/)
  end
end
