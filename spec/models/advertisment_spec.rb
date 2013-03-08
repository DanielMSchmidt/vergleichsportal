require 'spec_helper'

describe Advertisment do
  describe "validation of attributes" do

    it "should be an image_url present" do
      should validate_presence_of(:img_url)
    end

    it "should be a link_url present" do
      should validate_presence_of(:link_url)
    end
    describe "should be an url in image_url" do

      it "should be okay with an url" do
        a = Advertisment.new(img_url:"http://tibor-weiss.de/Fotos/2012Schandmaul/Schandmaul/content/images/thumb/IMG_3432.jpg", link_url:"http://www.tibor-weiss.de", active:false)
        a.should be_valid
      end
      it "shouldn't be okay with an invalid url" do
        a = Advertisment.new(img_url:"test", link_url:"http://www.tibor-weiss.de", active:false)
        a.should be_invalid
      end
    end

    describe "should be an url in link_url" do
      it "should be okay with an url" do
        a = Advertisment.new(img_url:"http://tibor-weiss.de/Fotos/2012Schandmaul/Schandmaul/content/images/thumb/IMG_3432.jpg", link_url:"http://www.tibor-weiss.de", active:false)
        a.should be_valid
      end
      it "shouldn't be okay with an invalid url" do
        a = Advertisment.new(img_url:"http://tibor-weiss.de/Fotos/2012Schandmaul/Schandmaul/content/images/thumb/IMG_3432.jpg", link_url:"http://www.tibor-weiss", active:false)
        a.should be_invalid
      end
    end
  end
end
