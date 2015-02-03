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

end
