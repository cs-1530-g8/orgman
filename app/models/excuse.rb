class Excuse < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  validates :event_id, presence: true
  validates :user_id,  presence: true
  validates :reason,   presence: true, length: { maximum: 150 }

  # Scopes #####################################################################

  # Associations ###############################################################

  belongs_to :user
  belongs_to :event
  has_one :attendance

  # Helpers ####################################################################
end
