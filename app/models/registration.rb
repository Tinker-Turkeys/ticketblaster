class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :invitee

  #validates :price, numericality: { greater_than_or_equal_to: 0 }

  attr_reader :custom_fields

  scope :remaining, -> { where(finalized: false) }
  scope :finalized, -> { where(finalized: true) }

  after_initialize :set_default, :deserialize_custom_fields
  before_save :match_to_invitation

  def custom_fields=(custom_fields)
    @custom_fields = custom_fields
    serialize_custom_fields
  end

  def custom_field_value(name)
    self.custom_fields[name]
  end

  def phone_number=(phone_number)
    write_attribute(:phone_number, normalize_phone_number(phone_number))
  end

  def self.next_registration_token(event)
    token = generate_token
    Registration.transaction do
      invitee_registering = Registration.where(finalized: false)
      .where("(token IS NULL OR updated_at < ?)", REGISTRATION_TIMEOUT.minutes.ago.to_s(:db))
        .where(event: event)
        .lock(true).first
      if invitee_registering.nil? || !invitee_registering.update(token: token)
        token = nil
      end
    end
    token
  end

  def self.update_by_token(token, params)
    registration = Registration.where(token: token)
      .where('updated_at > ?', REGISTRATION_TIMEOUT.minutes.ago).first
    if registration
      registration.attributes = params
      registration.finalized = true
    end
    registration
  end

  def labeled_data(options = {})
    event.custom_fields.map do |cf| 
      value = custom_field_value(cf.name)
      if value.is_a?(Array) && options[:arrays_to_strings] 
        value = value.join(", ")
      end
      [cf.label, value]
    end
  end

  def to_a(options = {})
    [
      ["Name", self.name], 
      ["Email", self.email], 
      ["Phone Number", self.phone_number]
    ] + self.labeled_data(options)
  end

  private

    def serialize_custom_fields
      self.custom_fields_json = self.custom_fields.to_json 
    end

    def deserialize_custom_fields
      unless self.custom_fields_json.nil?
        self.custom_fields = JSON.parse(self.custom_fields_json)
      end
    end

    def self.generate_token
      Digest::SHA1.hexdigest(rand.to_s)
    end

    def match_to_invitation
      if self.invitee.blank?
        self.invitee = event.invitees.where("phone_number = ? OR email = ?", 
          self.phone_number, self.email).first
      end
    end

    def normalize_phone_number(number)
      number.blank? ? "" : "+1" + number.gsub(/^[^0-9]*1|[^0-9]+/,'')
    end

    def set_default
      @custom_fields ||= {}
    end

end
