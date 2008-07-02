require 'text_line'
module Moo
  class Product < OptionsStruct.create(:url, :type, :crop, :lines, :font_size)
    
    def default_options
      {
        :lines => [],
        :crop => 'auto'
      }
    end
    
    def text=(content)
      content.split("\n").each{|line| @lines << TextLine.new(:string => line, :design => self) }
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
    
    def self.disable_attributes(attributes=[])
      attributes.each do |attribute|
        class_eval %{
          def #{attribute}=(*args)
            disable_attribute(#{attribute})
          end
        }
      end
    end
    
    def disable_attribute(attribute)
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
    disable_attributes [:font_size, :italic]
    
    def product_type
      "minicard"
    end
  end
end