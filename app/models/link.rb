class Link < ActiveRecord::Base
  scope :active, -> { where("expiration >= :today", today: Date.today)
                      .order(:name) }
end
