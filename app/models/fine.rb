class Fine < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  # Scopes #####################################################################

  scope :unpaid, -> { where(paid: false) }

  # Associations ###############################################################

  belongs_to :attendance
  has_one :event, through: :attendance
  has_one :user, through: :attendance

  # Helpers ####################################################################
end
