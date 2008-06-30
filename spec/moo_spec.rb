require File.join(File.dirname(__FILE__), *%w[spec_helper])

describe "an empty moo order" do
  before :each do
    @moo = Moo::Order.new :api_key => "TESTAPIKEY"
  end
  
  it "should have the appropiate header" do
    @moo.to_xml.should include('<moo xsi:noNamespaceSchemaLocation="http://www.moo.com/xsd/api_0.7.xsd">')
  end
  
  it "should user MOO API version 7" do
    @moo.to_xml.should include("<version>0.7</version>")
  end
  
  it "should include the API key" do
    @moo.to_xml.should include("<api_key>TESTAPIKEY</api_key>")
  end
  
  it "should call build" do
    @moo.to_xml.should include("<call>build</call>")
  end
end

describe "a moo order with a minicard" do
  before :each do
    @moo = Moo::Order.new :api_key => "TESTAPIKEY"
    @minicard = Moo::MiniCard.new(:url => "http://farm3.static.flickr.com/2300/2179038972_23d2a1ff40_o.jpg")
    @moo.designs << @minicard
  end
  
  it "should have product type of 'minicard'" do
    @moo.product_type.should == 'minicard'
    @moo.to_xml.should include('<product_type>minicard</product_type>')
  end
  
  it "should include the xml for the minicard" do
    @moo.to_xml.should include(@minicard.to_xml(Builder::XmlMarkup.new))
  end
end