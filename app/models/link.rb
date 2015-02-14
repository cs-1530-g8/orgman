class Link < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  validates :user_id, presence: true
  validates :url, presence: true
  validates :name, presence: true

  # Scopes #####################################################################

  scope :active, -> {
    where("expiration >= :today", today: Date.today).order(:name)
  }

  # Associations ###############################################################

  belongs_to :user

  # Helpers ####################################################################

end
