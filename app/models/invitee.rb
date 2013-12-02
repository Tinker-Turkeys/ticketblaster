class Invitee < ActiveRecord::Base
  belongs_to :event
  belongs_to :registration

  validates :name, length: { minimum: 2, maximum: 200 }

  scope :persisted, where("id IS NOT NULL")

end
