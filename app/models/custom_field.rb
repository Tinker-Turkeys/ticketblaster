class CustomField

  attr_accessor :label, :type, :name, :value, :options

  def initialize(attributes = {})
    self.label = attributes[:label]
    @type = attributes[:type]
    @value = attributes[:value]
    @options = attributes[:options]
  end

  def label=(label)
    if label
      @name = label.downcase.gsub(/[^a-z0-9 ]/i,'').strip.gsub(/\W+/,'-')
    end
    @label = label
  end

  def id_attr
    "registration_custom_fields_#{self.name}"
  end  

  def name_attr
    "registration[custom_fields][#{self.name}]#{ multi_value? ? '[]' : '' }"
  end

  def options_list
    self.options.strip.split(/\W*,\W*/)
  end

  def multi_value?
    self.type == "check_box"
  end

end