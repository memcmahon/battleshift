require 'rails_helper'

describe Ship, type: :model do
  let(:ship) { Ship.new(2) }
  it "should be created with all attributes" do
    expect(ship).to be_instance_of(Ship)
    expect(ship.length).to eq(2)
    expect(ship.damage).to eq(0)
  end

  it "should take on damage" do
    expect(ship.damage).to eq(0)

    ship.attack!

    expect(ship.damage).to eq(1)
  end

  it "should know if it is sunk" do
    expect(ship.is_sunk?).to be false

    ship.attack!
    ship.attack!

    expect(ship.is_sunk?)
  end
end
