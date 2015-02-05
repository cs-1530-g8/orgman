class Link < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  validates :user_id, presence: true

  # Scopes #####################################################################

  scope :active, -> {
    where("expiration >= :today", today: Date.today).order(:name)
  }

  # Associations ###############################################################

  belongs_to :user

  # Helpers ####################################################################

end
