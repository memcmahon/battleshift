require "digest"

class User < ApplicationRecord
  has_many :api_keys
  has_one :api_key, -> { where(status: "active")}
  belongs_to :game, optional: true


  after_create :set_activation_key
  after_create :set_api_key

  has_secure_password

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  private
    def set_activation_key
      sha = Digest::SHA1.hexdigest(email)
      update(activation_key: sha)
    end

    def set_api_key
      api_keys.create!(status: 'active')
    end
end
