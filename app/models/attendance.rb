class Attendance < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  # Scopes #####################################################################

  # Associations ###############################################################

  has_one :fine
  has_one :excuse
  belongs_to :event
  belongs_to :user

  # Helpers ####################################################################

  # Search #####################################################################

  def self.find_unfined
    Attendance.where(fine:    nil,
                     excused: false,
                     present: false,
                     event:   Event.find_fineable_event_ids)
  end
end
