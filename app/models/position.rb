class Position < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  # Scopes #####################################################################

  scope :exec,             -> { where(event_type_id: nil) }
  scope :event_type_admin, -> { where(name: nil) }

  # Associations ###############################################################

  belongs_to :user
  belongs_to :event_type

  # Helpers ####################################################################

  def default_position?
    is_default_position = false
    default_exec = ['Secretary', 'President', 'Treasurer']
    default_event_type_admin = [1]

    default_exec.each do |p|
      p = Position.find_by(name: p)
      if p.present? && p == self
        is_default_position = true
      end
    end

    default_event_type_admin.each do |p|
      et = EventType.find(p)
      if et.present? && self == et.position
        is_default_position = true
      end
    end
    is_default_position
  end
end
