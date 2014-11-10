class Link < ActiveRecord::Base
  scope :active, -> { where("expiration >= :today", today: Date.today) }
end
