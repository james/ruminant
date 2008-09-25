require 'text_line'
module Moo
  class Design < OptionsStruct.create(:url, :type, :crop, :lines, :font_size)
    def default_options
      {
        :lines => [],
        :crop => 'auto',
        :type => 'variable'
      }
    end
    
    def text=(content)
      content.split("\n").each{|line| lines << TextLine.new(:string => line, :design => self) }
    end
    
    def line(n)
      lines[n-1]
    end
    
    [:design, :string, :font_size, :bold, :italic, :align, :font, :colour].each do |text_attribute|
      class_eval %{
        # Sets #{text_attribute} attribute on all text lines
        def #{text_attribute}=(value)
          set_attribute_on_all_lines(:#{text_attribute}, value)
        end
      }
    end
    
    def self.disable_attributes(attributes=[])
      attributes.each do |attribute|
        class_eval %{
          def #{attribute}=(*args)
            raise DisabledAttributeError
          end
        }
      end
    end
    
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.design {
        xml.image {
          xml.url self.url
          xml.type self.type
          xml.crop {
            xml.auto true
          }
        }
        xml.text_collection {
          #xml.tag! product_type {
          # this needs changing for multiple product types
          xml.minicard {
            lines.each_with_index do |line, index|
              xml.text_line {
                xml.id index+1
                xml.string line.string
                xml.bold line.bold
                xml.align line.align
                xml.font line.font
                xml.colour line.colour
              }
            end
          }
        }
      }
    end
    
  private
    
    def set_attribute_on_all_lines(attribute, value)
      @lines.each{|line| line.send("#{attribute}=",value)}
    end
    
  end
  
  class MiniCard < Design
    disable_attributes [:font_size, :italic]
    
    def product_type
      "minicard"
    end
  end
  
  class Sticker < Design
    
    disable_attributes [:font, :font_size, :colour, :align, :bold, :string, :italic]
    
    def product_type
      "sticker"
    end
    
  end
  
  class DisabledAttributeError < StandardError
  end
end