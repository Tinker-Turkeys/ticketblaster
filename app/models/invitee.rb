class Invitee < ActiveRecord::Base
  belongs_to :event
  belongs_to :registration

  validates :name, length: { minimum: 2, maximum: 200 }
  validates :email, format: { with: /[a-z0-9._+-]+@[a-z0-9.-]+/i },
    allow_blank: true
  validates :phone_number, format: { with: /\+1[2-9][0-9]{9}/ },
    allow_blank: true

  validate :has_email_or_phone

  scope :persisted, where("id IS NOT NULL")

  def phone_number=(phone_number)
    write_attribute(:phone_number, normalize_phone_number(phone_number))
  end

  private

    def normalize_phone_number(number)
      number.blank? ? "" : "+1" + number.gsub(/^[^0-9]*1|[^0-9]+/,'')
    end

    def has_email_or_phone
      if self.email.blank? && self.phone_number.blank?
        errors[:base] << "You must specify an email address or phone number"
      end
    end
end
