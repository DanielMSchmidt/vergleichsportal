require 'spec_helper'

describe ArticleQueryAssignment do
  describe "validations" do
    it "should validate presence of article_id" do
      should validate_presence_of(:article_id)
    end
    it "should validate presence of search_querie_id" do
      should validate_presence_of(:search_query_id)
    end
  end

  describe "relations" do
    it "should belong to article" do
      should belong_to(:article)
    end
    it "should belong to search queries" do
      should belong_to(:search_query)
    end
  end

end
