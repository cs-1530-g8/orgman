class User < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :two_p_number,               length: { is: 15 }, allow_blank: true
  validates :peoplesoft_number,          length: { is: 7 },  allow_blank: true

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'

  # Scopes #####################################################################

  # Associations ###############################################################

  # Helpers ####################################################################

  def name
    "#{first} #{last}"
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
