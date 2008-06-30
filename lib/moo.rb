require 'rubygems'
require 'builder'
require 'products/minicard'

module Moo
  class Order
    attr_accessor :api_key, :designs
    
    def api_version
      0.7
    end
    
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
    
    def product_type
      @designs.first.product_type if @designs.first
    end
    
    def to_xml(xml=Builder::XmlMarkup.new)
      eval File.open(File.expand_path(File.dirname(__FILE__) + "/template.xml.builder")).read
      xml.to_s
    end
  end
end