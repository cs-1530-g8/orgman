class Attendance < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  # Scopes #####################################################################

  scope :pending_excuses, -> {
    where(excused: nil).where.not(excuse_reason: nil)
  }

  # Associations ###############################################################

  has_one :fine
  belongs_to :event
  belongs_to :user

  # Helpers ####################################################################

  # Search ####################################################################

  def self.find_existing_excuses(user)
    Attendance.where(user_id: user.id).where.not(excuse_reason: nil)
  end

  def self.find_possible_excuses(user)
    Attendance.where(excuse_reason: nil,
                     user_id: user.id,
                     event_id: Event.find_excusable_event_ids)
  end

  def self.find_unfined
    Attendance.where.not(id: Fine.all.pluck(:attendance_id)).
               where(excused: false,
                     present: false,
                     event_id: Event.find_fineable_event_ids)
  end
end
