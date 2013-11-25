class Event < ActiveRecord::Base
  validates :title, length: { minimum: 3 }
  validates :description, length: { minimum: 25, maximum: 10**6 }
  validate :legal_date_range
  validates :location, length: { minimum: 3 }
  validates :slots, numericality: { greater_than: 0 }, 
                    :if => Proc.new {|e| e.slots != -1}
  validates :published, inclusion: { in: [true, false] }
  validates :public, inclusion: { in: [true, false] }



  private

  def legal_date_range
    if self.occurring_on < Time.now
      errors[:occurring_on] << "Date must be in the future"
    elsif self.occurring_on > 365.days.from_now
      errors[:occurring_on] << "Event date must be within a year from now"
    end
  end

end
