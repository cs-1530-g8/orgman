class EventType < ActiveRecord::Base
  before_save { self.name = name.titleize }

  # Constants ##################################################################

  # Validations ################################################################

  validates :name, presence: true, length: { maximum: 20 }

  validates :points_required, numericality: { only_integer: true,
            greater_than: 0 }, allow_nil: true

  validates :percentage_attendance_required, numericality: { only_integer: true,
            greater_than: 0, less_than_or_equal_to: 100 }, allow_nil: true

  validates :points_required, absence: true,
            if: Proc.new { |e| e.percentage_attendance_required.present? }

  validates :percentage_attendance_required, absence: true,
            if: Proc.new { |e| e.points_required.present? }

  # Scopes #####################################################################

  scope :required, -> {
    where("points_required > 0 OR percentage_attendance_required > 0").
    order(:name)
  }
  scope :not_required, -> {
    where("(points_required = 0 OR points_required IS NULL) AND
           (percentage_attendance_required = 0 OR
            percentage_attendance_required IS NULL) ").
    where(points_required: nil, percentage_attendance_required: nil).
    order(:name)
  }

  # Associations ###############################################################

  has_many :events
  has_one :position

  # Helpers ####################################################################

  def required?
    points = self.points_required.present? && self.points_required > 0
    percentage = self.percentage_attendance_required.present? &&
                 self.percentage_attendance_required > 0
    points || percentage
  end
end
