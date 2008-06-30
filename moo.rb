class Moo::Order
  require 'rubygems'
  require 'builder'
  attr_accessor :api_key, :designs
  
  def initialize(options={})
    {
      :designs => []
    }.merge(options).each { |name, value|
      self.send("#{name}=",value)
    }
  end
  
  def add_design(options={})
    Design.new(options)
  end
  
  def to_xml
    xml = Builder::XmlMarkup.new
    eval File.open("/users/abscond/Rails/moo/template.xml.builder").read
    xml.to_s
  end
end