class CustomField

  include ActiveModel::Validations
  TYPES = %w(text_field radio_button check_box select)

  validates :type, inclusion: { in: TYPES }
  validates :label, length: { minimum: 1 }
  validates :options, length: { minimum: 1 }, if: :multi_option?

  attr_accessor :label, :type, :name, :value, :options

  def initialize(attributes = {})
    self.label = attributes[:label]
    @type = attributes[:type]
    @value = attributes[:value] ? sanitize_list(attributes[:value]) : ""
    @options = attributes[:options] ? sanitize_list(attributes[:options]) : ""
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

  def multi_option?
    self.type != "text_field" 
  end

  def explanation
    if self.options && self.options[1]
      conjunction = multi_value? ? 'and' : 'or'
      "One #{ multi_value? ? 'or more' : '' } of these options: " +
        self.options.gsub(",",", ").sub(/(.*),/, '\1 ' + conjunction)
    elsif self.type == 'text_field'
      "Free form response"
    elsif multi_value?
      "Confirmation"
    end
  end

  def self.types
    TYPES
  end

  private

    def sanitize_list(list)
      list.strip.split(/\W*,\W*/).join(',')
    end

end