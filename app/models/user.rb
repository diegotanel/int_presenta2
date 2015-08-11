#encoding: utf-8
class User < ActiveRecord::Base

  attr_accessor :password_confirmation

  has_many :formularios, dependent: :destroy
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 100}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
    uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}
  validate :password_and_password_confirmation_equal

  def password_and_password_confirmation_equal
    if self.password != self.password_confirmation
      errors.add(:password_confirmation, "tiene que ser igual que Contraseña")
    end
  end

  def authenticate(password)
    password == self.password
  end

  def admin?
    ["fomento@inteatro.gov.ar", "coordinacion@inteatro.gov.ar", "dtanel@gmail.com"].include?(self.email)
  end

  def jurado?
    ["galiakohan@hotmail.com", "gracielastrappa@hotmail.com", "sandramonteagudo@smandes.com.ar", "arianagomez@yahoo.com.ar", "claudiop@artesescenicas.org.ar", "mariacristina711@yahoo.com.ar"].include?(self.email)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
