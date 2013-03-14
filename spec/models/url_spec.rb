require 'spec_helper'

describe Url do
  describe "validations" do
    it "should validate presence of name" do
      should validate_presence_of(:value)
    end
  end

  describe "relations" do
    it "should belong to an article" do
      should belong_to(:article)
    end
    it "should belong to a provider" do
      should belong_to(:provider)
    end
  end
end
