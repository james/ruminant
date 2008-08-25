require File.join(File.dirname(__FILE__), *%w[spec_helper])

describe "an empty moo order" do
  before :each do
    @moo = Moo::Order.new :api_key => "TESTAPIKEY"
  end
  
  it "should have the appropiate header" do
    @moo.to_xml.should include('<?xml version="1.0" encoding="UTF-8"?><moo xsi:noNamespaceSchemaLocation="http://www.moo.com/xsd/api_0.7.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">')
  end
  
  it "should user MOO API version 0.7" do
    @moo.to_xml.should include("<version>0.7</version>")
  end
  
  it "should include the API key" do
    @moo.to_xml.should include("<api_key>TESTAPIKEY</api_key>")
  end
  
  it "should call build" do
    @moo.to_xml.should include("<call>build</call>")
  end
  
  it "should not contain to_s" do
    @moo.to_xml.should_not include("to_s")
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
    @moo.to_xml.should include(@minicard.to_xml)
  end
end

describe "processing an XML response for failure" do
  before :each do
    @moo = Moo::Order.new :api_key => "TESTAPIKEY"
    @moo.stub!(:raw_response).and_return('<?xml version="1.0" encoding="UTF-8"?> <moo>  <response>  <call>build</call>  <error>true</error>  </response>  <payload>  <error_code>1</error_code>  <error_string>Error importing XML document</error_string>  </payload> </moo>')
    @moo.process_response
  end
  
  it "should set error? as true" do
    @moo.error?.should be_true
  end
  
  it "should set error_string correctly" do
    @moo.error_string.should == "Error importing XML document"
  end
  
  it "should set error_code correctly" do
    @moo.error_code.should == "1"
  end
end


describe "processing an XML response for success" do
  before :each do
    @moo = Moo::Order.new :api_key => "TESTAPIKEY"
    @moo.stub!(:raw_response).and_return('<?xml version="1.0" encoding="UTF-8"?> <moo> <response> <call>build</call> <api_key>3ddbe3c0-17ac-c0a802d2-47bafd19-2473</api_key> </response> <payload> <session_id>d4c7a6d179fca910d67221a57a1bf966</session_id> <start_url>http://www.moo.com/make/designback.php?bid=1&pid=115&SID=d4c7a6d179fca910d67221a57a1bf966</start_url> </payload> </moo>')
    @moo.process_response
  end
  
  it "should set error? as false" do
    @moo.error?.should be_false
  end
  
  it "should set start_url correctly" do
    @moo.start_url.should == "http://www.moo.com/make/designback.php?bid=1&pid=115&SID=d4c7a6d179fca910d67221a57a1bf966"
  end
  
  it "should set session_id correctly" do
    @moo.session_id.should == "d4c7a6d179fca910d67221a57a1bf966"
  end
end