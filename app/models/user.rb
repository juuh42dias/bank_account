class User < ApplicationRecord
  has_secure_password
  has_many :accounts, dependent: :destroy

  validates :email, :password, presence: true, on: :create
end
