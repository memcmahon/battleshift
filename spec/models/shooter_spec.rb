require 'rails_helper'

describe Shooter, type: :model do
  let(:board) { Board.new(4) }
  let(:target) { "A1" }

  xit "can fire a shot" do
    result = Shooter.fire!(board: board, target: target)

    binding.pry
  end
end
