class Event < ActiveRecord::Base

  has_many :registrations
  
  attr_accessor :custom_fields


  validates :title, length: { minimum: 3 }
  validates :description, length: { minimum: 25, maximum: 10**6 }
  validate :legal_date_range
  validates :location, length: { minimum: 3 }
  validates :slots, numericality: { greater_than: 0 }, 
                    :if => Proc.new {|e| e.slots != -1}
  validates :published, inclusion: { in: [true, false] }
  validates :public, inclusion: { in: [true, false] }

  before_save :serialize_custom_fields
  after_initialize :set_default
  after_initialize :deserialize_custom_fields

  def add_custom_fields(custom_fields_hash)
    if custom_fields_hash
      custom_fields_hash.each do |custom_field|
        @custom_fields << CustomField.new(custom_field)
      end
    end
  end

  private

    def legal_date_range
      if self.occurring_on.nil?
        errors[:occurring_on] << "You must define an event date"
      elsif Time.now > self.occurring_on
        errors[:occurring_on] << "Date must be in the future"
      elsif 365.days.from_now < self.occurring_on 
        errors[:occurring_on] << "Event date must be within a year from now"
      end
    end

    def set_default
      @custom_fields = []
    end

    def serialize_custom_fields
      self.form_fields = self.custom_fields.map { |p| p.instance_values }.to_json
    end

    def deserialize_custom_fields
      if self.persisted?
        custom_fields_array = JSON.parse(self.form_fields, symbolize_names: true)
        self.custom_fields = custom_fields_array.map { |c| CustomField.new(c) }
      end
    end

end
