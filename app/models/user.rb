class User < ActiveRecord::Base
  # Constants ##################################################################

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

  scope :active,   -> { where("status = 'active'").
                        sort_by { |u| [u.last_name, u.first_name] } }
  scope :alumni,   -> { where("status = 'alumni'").
                        sort_by { |u| [u.last_name, u.first_name] } }
  scope :pending,  -> { where("status = 'pending'").
                        sort_by { |u| [u.last_name, u.first_name] } }
  scope :inactive, -> { where("status = 'inactive'").
                        sort_by { |u| [u.last_name, u.first_name] } }

  # Associations ###############################################################

  has_many :attendances
  has_many :events, through: :attendances
  has_many :excuses
  has_many :fines
  has_one :position

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
