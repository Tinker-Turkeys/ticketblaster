class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :invitee

  #validates :price, numericality: { greater_than_or_equal_to: 0 }

  attr_accessor :custom_fields

  scope :remaining, where(finalized: false)
  scope :finalized, where(finalized: true)

  after_initialize :set_default
  before_save :match_to_invitation

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

  private

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
