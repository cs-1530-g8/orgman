class User < ActiveRecord::Base
  # Constants ##################################################################

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Validations ################################################################

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :password,                   length: { minimum: 6  }
  validates :two_p_number,               length: { is: 15 }, allow_blank: true
  validates :peoplesoft_number,          length: { is: 7 },  allow_blank: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'

  # Scopes #####################################################################

  # Before #####################################################################

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  # Associations ###############################################################

  # Helpers ####################################################################

  def name
    "#{first} #{last}"
  end

  # Authentication #############################################################

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
