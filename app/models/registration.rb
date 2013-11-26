class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
