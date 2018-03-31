require 'rails_helper'

describe Shooter, type: :model do
  let(:board) { Board.new(4) }
  let(:target) { "A1" }
  let(:subject) { Shooter.new(board: board, target: target)}

  it "exists" do
    expect(subject).to be_instance_of Shooter
  end

  it "can fire a shot" do
    result = subject.fire!

    expect(result).to eq("Miss")
  end
end
