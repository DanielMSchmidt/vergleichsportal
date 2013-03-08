require 'spec_helper'

describe "advertisments/edit" do
  before(:each) do
    @advertisment = assign(:advertisment, stub_model(Advertisment,
      :img_url => "MyString",
      :link_url => "MyString",
      :active => false
    ))
  end

  it "renders the edit advertisment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advertisment_path(@advertisment), "post" do
      assert_select "input#advertisment_img_url[name=?]", "advertisment[img_url]"
      assert_select "input#advertisment_link_url[name=?]", "advertisment[link_url]"
      assert_select "input#advertisment_active[name=?]", "advertisment[active]"
    end
  end
end
