class Event < ActiveRecord::Base
  before_save { self.name = name.titleize }

  # Constants ##################################################################

  # Validations ################################################################

  # Scopes #####################################################################

  scope :excusable, -> { where(self_submit_excuse: true) }

  # Associations ###############################################################

  has_many :attendances
  has_many :users, through: :attendances
  has_many :fines, through: :attendances
  has_many :excuses
  belongs_to :event_type

  # Helpers ####################################################################

  def attended_users
    self.attendances.where(present: true).collect(&:user)
  end

  def absent_users
    self.attendances.where(present: false).collect(&:user)
  end
end
