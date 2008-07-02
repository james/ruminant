class OptionsStruct
  def self.create(*accessors)
    class_eval "attr_accessor" + accessors.join(", ")
  end
  
  def default_options
    {}
  end
  
  def initialize(options={})
    default_options.merge(options).each do |name, value|
      self.send("#{name}=",value)
    end
  end
end