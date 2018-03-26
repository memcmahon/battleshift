require "digest"

class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email

  def activation_key
    Digest::SHA256.hexdigest email
  end
end
