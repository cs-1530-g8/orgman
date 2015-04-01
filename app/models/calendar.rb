class Calendar < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  validates :name, presence: true
  validates :url, presence: true

  # Callbacks ##################################################################

  before_validation { self.url += "&showTitle=0" }
  before_save { adjust_primary }

  # Scopes #####################################################################

  scope :primary_calendar, -> { find_by(primary: true) }
  scope :non_primary_calendars, -> { where(primary: false) }

  # Associations ###############################################################

  # Helpers ####################################################################

  def self.exclude(id)
    where.not(id: id)
  end

  private

  def adjust_primary
    if Calendar.count == 0
      primary = true
    elsif primary
      old_primary_calendar = Calendar.primary_calendar
      if old_primary_calendar.present?
        old_primary_calendar.update(primary: false)
      end
    end
  end
end
