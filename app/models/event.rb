class Event < ActiveRecord::Base
  include EventsHelper

  # Constants ##################################################################

  # Validations ################################################################

  validates :name, presence: true
  validates :semester, presence: true
  validates :event_type_id, presence: true
  validates :date, presence: true

  # Callbacks ##################################################################

  before_save { self.name = name.titleize }
  before_validation { self.semester = current_semester(Time.now.year) }

  # Scopes #####################################################################

  scope :excusable, -> {
    where("self_submit_excuse = :value AND date > :today", today: Date.today,
                                                           value: true)
  }

  # Associations ###############################################################

  has_many :attendances
  has_many :users, through: :attendances
  has_many :fines, through: :attendances
  belongs_to :event_type

  # Helpers ####################################################################

  def attended_users
    attendances.where(present: true).map(&:user).
      sort_by { |u| [u.last_name, u.first_name] }
  end

  def absent_users
    attendances.where(present: false).map(&:user).
      sort_by { |u| [u.last_name, u.first_name] }
  end

  def excused_users
    attendances.where(excused: true).map(&:user).
      sort_by { |u| [u.last_name, u.first_name] }
  end

  # Search #####################################################################

  def self.find_excusable_event_ids
    Event.where("date > :today", today: Date.today).
      where(self_submit_excuse: true).pluck(:id)
  end

  def self.find_fineable_event_ids
    Event.where("date < :today", today: Date.today).
      where.not(fine: nil).pluck(:id)
  end
end
