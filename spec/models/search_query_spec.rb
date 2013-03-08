require 'spec_helper'

describe SearchQuery do
  describe "validations" do
    it "should validate presence of value" do
      should validate_presence_of(:value)
    end
  end

  describe "relations" do
    it "should have many articles" do
      should have_many(:articles).through(:article_query_assignments)
    end
  end
end
