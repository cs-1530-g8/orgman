class Event < ActiveRecord::Base
  before_save { self.name = name.titleize }

  has_many :attendances
  has_many :members, through: :attendances
  belongs_to :event_type

  def attended_users
    self.attendances.where(present: true).collect(&:user)
  end

  def absent_users
    self.attendances.where(present: false).collect(&:user)
  end
end
