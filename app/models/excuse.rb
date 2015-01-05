class Excuse < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  validates :reason,         presence: true, length: { maximum: 150 }
  validates :user_id,        presence: true
  validates :event_id,       presence: true
  validates :attendance_id,  presence: true

  # Scopes #####################################################################

  scope :pending, -> { where(accepted: nil) }

  # Associations ###############################################################

  belongs_to :user
  belongs_to :event
  has_one :attendance

  # Helpers ####################################################################
end