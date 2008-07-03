module OptionsStruct
  def self.create(*accessors)
    Class.new do
      attr_accessor *accessors
      include Methods
    end
  end
  
  module Methods
    def default_options
      {}
    end
  
    def initialize(options={})
      default_options.merge(options).each do |name, value|
        self.send("#{name}=",value)
      end
    end
  end
end