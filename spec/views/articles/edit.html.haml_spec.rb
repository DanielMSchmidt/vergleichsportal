require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :name => "MyString",
      :ean => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", article_path(@article), "post" do
      assert_select "input#article_name[name=?]", "article[name]"
      assert_select "input#article_ean[name=?]", "article[ean]"
      assert_select "textarea#article_description[name=?]", "article[description]"
    end
  end
end
