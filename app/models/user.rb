class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email
end
