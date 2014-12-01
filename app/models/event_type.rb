class EventType < ActiveRecord::Base
  before_save { self.name = name.titleize }

  has_many :events

  validates :name, presence: true, length: { maximum: 20 }

  validates :points_required, numericality: { only_integer: true,
            greater_than: 0 }, allow_nil: true

  validates :percentage_attendance_required, numericality: { only_integer: true,
            greater_than: 0, less_than_or_equal_to: 100 }, allow_nil: true

  validates :points_required, absence: true,
            if: Proc.new { |e| e.percentage_attendance_required.present? }

  validates :percentage_attendance_required, absence: true,
            if: Proc.new { |e| e.points_required.present? }

  def required?
    self.points_required > 0 || self.percentage_attendance_required > 0
  end

  def not_required?
    self.points_required = 0 && self.percentage_attendance_required = 0
  end

  scope :required, -> {
    where("points_required > 0 OR percentage_attendance_required > 0").
    order(:name)
  }
  scope :not_required, -> {
    where("points_required = 0 AND percentage_attendance_required = 0").
    order(:name)
  }
end
