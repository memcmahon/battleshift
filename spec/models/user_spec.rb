require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
  end

  describe "Relationships" do
    it { should belong_to :game }
    it { should have_many :api_keys }
    it { should have_one :api_key }
  end

  describe "Builds Keys" do
    let(:user) { create(:user) }
    it "should set activation key on creation" do
      expect(user.activation_key).to be_a String
    end

    it "should set api key on creation" do
      expect(user.api_key).to be_instance_of ApiKey
    end
  end
end
