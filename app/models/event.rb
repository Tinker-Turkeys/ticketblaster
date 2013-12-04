class Event < ActiveRecord::Base

  has_many :registrations
  has_many :invitees

  attr_accessor :custom_fields

  validates :title, length: { minimum: 3 }
  validates :description, length: { minimum: 25, maximum: 10**6 }
  validates :location, length: { minimum: 3 }
  validates :slots, numericality: { greater_than: 0 }, 
                    :if => Proc.new {|e| e.slots != -1}
  validates :published, inclusion: { in: [true, false] }
  validates :public, inclusion: { in: [true, false] }
  
  validate :proper_custom_fields
  validate :legal_date_range

  after_initialize :set_default, :deserialize_custom_fields
  after_create :generate_registrations

  def add_custom_fields(custom_fields_hash)
    @custom_fields = []
    if custom_fields_hash
      custom_fields_hash.each do |custom_field|
        unless custom_field[:ignore]
          @custom_fields << CustomField.new(custom_field)
        end
      end
      serialize_custom_fields
    end
  end

  def custom_fields_json=(custom_fields)
    write_attribute(:custom_fields_json, custom_fields)
    deserialize_custom_fields
  end

  def expired?
    self.occurring_on < Time.now
  end

  def total_spaces
    self.registrations.count
  end

  def spaces_remaining
    self.registrations.where(finalized: false).count
  end

  def spaces_filled
    self.registrations.count - self.spaces_remaining
  end

  def full?
    self.spaces_remaining == 0
  end

  def self.open
    where(public: true).joins(:registrations).where(registrations: { finalized: false }).group("events.id")
  end

  def cancel!
    self.update(canceled: true)
  end

  def finalized_registrations
    self.registrations.where(finalized: true)
  end

  private

    def proper_custom_fields
      self.custom_fields.each do |custom_field|
        unless custom_field.valid?
          errors[:custom_fields] << custom_field.errors.full_messages.first
        end
      end
    end

    def generate_registrations
      self.slots.times do
        self.registrations.create
      end
    end

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
      self.custom_fields_json = self.custom_fields.map { |p| p.instance_values }.to_json
    end

    def deserialize_custom_fields
      unless self.custom_fields_json.nil?
        custom_fields_array = JSON.parse(self.custom_fields_json, symbolize_names: true)
        self.custom_fields = custom_fields_array.map { |c| CustomField.new(c) }
      end
    end

end
