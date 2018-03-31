require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "Validations" do
    it { should validate_presence_of :player_1_board }
    it { should validate_presence_of :player_2_board }
  end
  
  describe "Relationships" do
    it { should belong_to :player_1 }
    it { should belong_to :player_2 }
  end
end
