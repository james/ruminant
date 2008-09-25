require File.join(File.dirname(__FILE__), *%w[spec_helper])

describe "a minicard" do
  before :each do
    @design = Moo::MiniCard.new(:url => "http://farm3.static.flickr.com/2300/2179038972_23d2a1ff40_o.jpg")
  end
  
  it "should have minicard as the type" do
    @design.product_type.should == "minicard"
  end
  
  it "should not support size" do
    lambda{@design.font_size = 0.5}.should raise_error(Moo::DisabledAttributeError)
  end
  
  it "should not support italic" do
    lambda{@design.italic = true}.should raise_error(Moo::DisabledAttributeError)
  end
end

describe "a sticker" do
  before(:each) do
    @design = Moo::Sticker.new(:url => "")
  end
  
  it "should have sticker as the type" do
    @design.product_type.should == "sticker"
  end
  
  it "should not support font size" do
    lambda{@design.font_size = 0.5}.should raise_error(Moo::DisabledAttributeError)
  end
  
  it "should not support italic" do
    lambda{@design.italic = true}.should raise_error(Moo::DisabledAttributeError)
  end
  
  it "should not support string" do
    lambda{@design.string = "foo"}.should raise_error(Moo::DisabledAttributeError)
  end
  
  it "should not support bold" do
    lambda{@design.bold = true}.should raise_error(Moo::DisabledAttributeError)
  end
  
  it "should not support align" do
    lambda{@design.align = "centre"}.should raise_error(Moo::DisabledAttributeError)
  end
  
  it "should not support font" do
    lambda{@design.font = "Normal"}.should raise_error(Moo::DisabledAttributeError)
  end
  
  it "should not support colour" do
    lambda{@design.colour = "#ccc"}.should raise_error(Moo::DisabledAttributeError)
  end
end