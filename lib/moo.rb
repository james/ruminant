require 'core_ext/options_struct'
require 'rubygems'
require 'builder'
require 'design'

module Moo
  class Order < OptionsStruct.create(:api_key, :designs)
    def api_version
      0.7
    end
    
    def default_options
      {
        :designs => [],
        :api_key => 0
      }
    end
    
    def product_type
      @designs.first.product_type if @designs.first
    end
    
    def to_xml(xml=Builder::XmlMarkup.new)
      eval File.open(File.expand_path(File.dirname(__FILE__) + "/template.xml.builder")).read
      xml
    end
    
    def submit
      @api = API.new
      @api.send_order(self)
    end
  end
  
end