class User < ActiveRecord::Base
  # Constants ##################################################################

  SECRETARY = "Secretary"
  PRESIDENT = "President"
  TREASURER = "Treasurer"

  ACTIVE = "active"
  ALUMNI = "alumni"
  PENDING = "pending"
  INACTIVE = "inactive"
  ORG_CHART_DUMMY = "org_chart_dummy"

  # Validations ################################################################

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :two_p_number,               length: { is: 15 }, allow_blank: true
  validates :address, allow_blank: true, length: { maximum: 100 }
  validates :phone_number,               length: { is: 10 }, allow_blank: true
  validates :about, allow_blank: true,   length: { maximum: 150 }
  validates :peoplesoft_number, numericality: { only_integer: true,
            greater_than: 1000000, less_than: 10000000 },
            length: { is: 7 }, allow_blank: true

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment :avatar, size: { in: 0..2.megabytes },
                       content_type: { content_type: ["image/jpg","image/jpeg",
                                                      "image/png","image/gif"] }

  # Scopes #####################################################################

  scope :active, -> {
    where(status: User::ACTIVE).sort_by { |u| [u.last_name, u.first_name] }
  }
  scope :alumni, -> {
    where(status: User::ALUMNI).sort_by { |u| [u.last_name, u.first_name] }
  }
  scope :pending, -> {
    where(status: User::PENDING).sort_by { |u| [u.last_name, u.first_name] }
  }
  scope :inactive, -> {
    where(status: User::INACTIVE).sort_by { |u| [u.last_name, u.first_name] }
  }
  scope :not_pending, -> {
    where.not(status: User::PENDING)
  }
  scope :org_chart_dummy, -> {
    where(status: User::ORG_CHART_DUMMY)
  }
  scope :unassigned_to_org_chart, -> {
    where.not(status: User::PENDING).where(division: nil)
  }

  # Associations ###############################################################

  has_many :attendances
  has_many :events, through: :attendances
  has_many :fines, through: :attendances
  has_many :links
  has_one :position

  # Helpers ####################################################################

  def has_position(position_string)
    position.present? && position == position.find_by(name: position_string)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def total_attendance_points
    self.attendances.where(present: true).count
  end

  def valid_event_types
    if position == Position.find_by(name: User::SECRETARY)
      EventType.all
    else
      [position.event_type]
    end
  end

  # Authentication #############################################################

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  devise :database_authenticatable, :registerable, :rememberable, :trackable,
         :validatable, :lockable, :timeoutable
end
