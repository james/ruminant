require File.join(File.dirname(__FILE__), *%w[spec_helper])

describe "The Design base class" do
  before :each do
    @design = Moo::Design.new(:url => "http://farm3.static.flickr.com/2300/2179038972_23d2a1ff40_o.jpg")
    @design.stub!(:product_type).and_return("minicard")
  end
  
  it "should include the design's photo url" do
    @design.to_xml.should include("<url>http://farm3.static.flickr.com/2300/2179038972_23d2a1ff40_o.jpg</url>")
  end
  
  it "should create multiple TextLines from a multi line string" do
    @design.text = "This is Line 1\nAnd this is the second line"
    @design.line(1).class.should == Moo::TextLine
    @design.line(1).string.should == "This is Line 1"
    @design.line(2).class.should == Moo::TextLine
    @design.line(2).string.should == "And this is the second line"
  end
end