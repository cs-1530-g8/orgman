class User < ActiveRecord::Base
  # Constants ##################################################################

  def self.president
    'president'
  end

  def self.vice_president
    'vice president'
  end

  def self.secretary
    'secretary'
  end

  def self.treasurer
    'treasurer'
  end

  def self.alumni_relations
    'alumni relations'
  end

  def self.risk_manager
    'risk manager'
  end

  def self.recruitment
    'recruitment'
  end

  def self.social
    'social'
  end

  def self.amc
    'amc'
  end

  def self.jamc
    'jamc'
  end

  def self.house_manager
    'house manager'
  end

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
  validates_attachment :avatar, content_type: { content_type: ["image/jpg",
                       "image/jpeg", "image/png", "image/gif"] },
                       size: { in: 0..2.megabytes }

  # Scopes #####################################################################

  scope :active,   -> { where("status = 'active'") }
  scope :alumni,   -> { where("status = 'alumni'") }
  scope :pending,  -> { where("status = 'pending'") }
  scope :inactive, -> { where("status = 'inactive'") }

  # Associations ###############################################################

  has_many :attendances
  has_many :events, through: :attendances

  # Helpers ####################################################################

  def name
    "#{first_name} #{last_name}"
  end

  def total_attendance_points
    self.attendances.where(present: true).count
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

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
end
