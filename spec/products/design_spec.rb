require File.join(File.dirname(__FILE__), *%w[../spec_helper])

describe "The design base class" do
  before :each do
    @design = Moo::Design.new(:url => "http://farm3.static.flickr.com/2300/2179038972_23d2a1ff40_o.jpg")
  end
  
  it "should include the design's photo url" do
    @design.to_xml.should include("<url>http://farm3.static.flickr.com/2300/2179038972_23d2a1ff40_o.jpg</url>")
  end
end