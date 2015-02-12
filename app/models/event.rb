class Event < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  validates :name, presence: true
  validates :semester, presence: true
  validates :event_type_id, presence: true
  validates :date, presence: true

  # Callbacks ##################################################################

  before_save { self.name = name.titleize }

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

  # Search #####################################################################

  def self.find_fineable_event_ids
    Event.where("date < :today", today: DateTime.today).
          where.not(fine: nil).
          pluck(:id)
  end
end
