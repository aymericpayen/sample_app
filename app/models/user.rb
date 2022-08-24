class User < ApplicationRecord
  # Bang method used to force email of user to change for good to te downcase version
  before_save  {email.downcase!}# = {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255},
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  # "has_secure_password" enforces validations on the virtual password and password_confirmation
  has_secure_password
  validates :password, length: {minimum:6}, presence: true
end
