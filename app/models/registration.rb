class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  #validates :price, numericality: { greater_than_or_equal_to: 0 }

  attr_accessor :custom_fields

  after_initialize :set_default

  def custom_field_value(name)
    self.custom_fields[name]
  end

    private

    def set_default
      @custom_fields ||= {}
    end

end
