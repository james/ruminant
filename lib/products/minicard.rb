require 'products/design'
module Moo
  class MiniCard < Design
    disable_attribute :font_size
    
    def product_type
      "minicard"
    end
  end
end