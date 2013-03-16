require 'rake'
require 'spec_helper'

describe "Searches" do
  before(:all) do
    Rake::Task['db:test:initialize'].invoke
  end

  it "should have the providers in the database" do
    Provider.count.should eq(2)
  end

  describe "a search without using the real providers" do
    it "should be able to start a search"
    it "should be able to update prices"
  end
  describe "a search with the real providers" do
    it "should be able to start a search"
    it "should be able to update prices"
  end
end

