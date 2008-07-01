module Moo
  class TextLine
    attr_accessor :text, :bold, :italic
    
    def initialize(options={})
      {
        :text => ""
      }.merge(options).each { |name, value|
        self.send("#{name}=",value)
      }
    end
  end
end