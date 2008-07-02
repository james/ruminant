require 'text_line'
module Moo
  class Product
    attr_accessor :url, :type, :crop, :lines, :font_size
    
    def initialize(options={})
      {
        :lines => []
      }.merge(options).each { |name, value|
        self.send("#{name}=",value)
      }
    end
    
    def text=(content)
      content.split("\n").each{|line| @lines << TextLine.new(:text => line) }
    end
    
    def line(n)
      lines[n-1]
    end
    
    def bold=(value)
      set_attribute_on_all_lines(:bold, value)
    end
    
    def set_attribute_on_all_lines(attribute, value)
      @lines.each{|line| line.send(attribute,value)}
    end
    
    def self.disable_attribute(attribute)
      class_eval %{
        def #{attribute}=(*args)
          disabled_attribute(#{attribute})
        end
      }
    end
    
    def disabled_attribute(attribute)
      raise "#{self.class} does not support #{attribute}"
    end
    
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.design {
        xml.image {
          xml.url self.url
        }
      }
    end
  end
  
  class MiniCard < Product
    disable_attribute :font_size
    
    def product_type
      "minicard"
    end
  end
end