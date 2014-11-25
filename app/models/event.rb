class Event < ActiveRecord::Base
  before_save { self.name = name.titleize }

  has_many :attendances
  has_many :members, through: :attendances
  belongs_to :event_type

  def attended_members
    self.attendances.where(present: true).collect(&:member)
  end

  def absent_members
    self.attendances.where(present: false).collect(&:member)
  end
end
