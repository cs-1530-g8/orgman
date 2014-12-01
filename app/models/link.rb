class Link < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  # Scopes #####################################################################

  scope :active, -> {
    where("expiration >= :today", today: Date.today) .order(:name)
  }

  # Associations ###############################################################

  # Helpers ####################################################################

end
