require "spec_helper"

describe AdvertismentsController do
  describe "routing" do

    it "routes to #index" do
      get("/advertisments").should route_to("advertisments#index")
    end

    it "routes to #new" do
      get("/advertisments/new").should route_to("advertisments#new")
    end

    it "routes to #show" do
      get("/advertisments/1").should route_to("advertisments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advertisments/1/edit").should route_to("advertisments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advertisments").should route_to("advertisments#create")
    end

    it "routes to #update" do
      put("/advertisments/1").should route_to("advertisments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advertisments/1").should route_to("advertisments#destroy", :id => "1")
    end

  end
end
