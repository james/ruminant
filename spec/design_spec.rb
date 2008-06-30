require File.join(File.dirname(__FILE__), *%w[spec_helper])

describe "a minicard" do
  before :each do
    @design = Moo::Design.new(:url => "http://farm3.static.flickr.com/2300/2179038972_23d2a1ff40_o.jpg")
  end
  
  it "should have product type of 'minicard'" do
    @moo.product_type.should == 'minicard'
    @moo.to_xml.should include('<product_type>minicard</product_type>')
  end
  
  it "should include the minicard's photo url" do
    @moo.to_xml.should include("<url>http://farm3.static.flickr.com/2300/2179038972_23d2a1ff40_o.jpg</url>")
  end
end