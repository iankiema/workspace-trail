class User < ApplicationRecord
  enum role: {user:  0, admin:  1}

  has_secure_password
  has_many :packages
  has_many :reservations
  has_one :admin

  validates_presence_of :email, :username
  validates_uniqueness_of :email, :username
end
