require "digest"

class User < ApplicationRecord
  after_create :set_activation_key
  
  has_secure_password

  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email


  def set_activation_key
    sha = Digest::SHA1.hexdigest(email)
    update(activation_key: sha)
  end
end
