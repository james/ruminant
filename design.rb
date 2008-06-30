class Moo::Design
  require 'minicard'
  attr_accessor :url, :type, :crop, :lines
  
  def initialize(options={})
    {
      :lines => []
    }.merge(options).each { |name, value|
      self.send("#{name}=",value)
    }
  end
  
  def text=(content)
    content.split("\n").each{|line| lines << line}
  end
end