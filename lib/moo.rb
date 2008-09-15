require 'core_ext/options_struct'
require 'rubygems'
require 'builder'
require 'design'

require 'net/http'
require 'uri'
require 'hpricot'

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
      xml = Builder::XmlMarkup.new(:target => (@xml_string = "")) unless xml
      eval File.open(File.expand_path(File.dirname(__FILE__) + "/template.xml.builder")).read
      xml.target!
    end
    
    attr_accessor :raw_response, :error_string, :error_code, :session_id, :start_url
    def submit
      res = Net::HTTP.post_form(URI.parse('http://www.moo.com/api/api.php'),
                                    {'xml'=>self.to_xml, 'method'=>'direct'})
      @raw_response = res.body
      process_response
      !error?
    end
    
    def process_response
      @response = Hpricot(raw_response)
      if error?
        @error_string = @response.search('error_string').inner_html
        @error_code = @response.search('error_code').inner_html
      else
        @session_id = @response.search('session_id').inner_html
        @start_url = @response.search('start_url').inner_html
      end
    end
    
    def error?
      @error ||= (@response.search('error').inner_html == "true")
    end
  end
  
end