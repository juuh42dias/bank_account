class User < ApplicationRecord
  has_secure_password

  validates :email, :password, presence: true
end
