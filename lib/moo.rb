require 'core_ext/options_struct'
require 'rubygems'
require 'builder'
require 'design'
require 'net/http'
require 'uri'

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
    
    def to_xml(xml=nil)
      xml = Builder::XmlMarkup.new(:target => (@xml_s ||= "")) unless xml
      eval File.open(File.expand_path(File.dirname(__FILE__) + "/template.xml.builder")).read
      xml.target!
    end
    
    def submit
      res = Net::HTTP.post_form(URI.parse('http://www.moo.com/api/api.php'),
                                    {'xml'=>self.to_xml, 'method'=>'direct'})
      puts res.body
    end
  end
  
end