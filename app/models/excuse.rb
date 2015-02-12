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

  has_one :user, through: :attendance
  has_one :event, through: :attendance
  belongs_to :attendance

  # Helpers ####################################################################
end
