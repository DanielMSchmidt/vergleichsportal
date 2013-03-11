require 'spec_helper'

describe "advertisments/new" do
  before(:each) do
    assign(:advertisment, stub_model(Advertisment,
      :img_url => "MyString",
      :link_url => "MyString",
      :active => false
    ).as_new_record)
  end

  it "renders new advertisment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advertisments_path, "post" do
      assert_select "input#advertisment_img_url[name=?]", "advertisment[img_url]"
      assert_select "input#advertisment_link_url[name=?]", "advertisment[link_url]"
      assert_select "input#advertisment_active[name=?]", "advertisment[active]"
    end
  end
end
