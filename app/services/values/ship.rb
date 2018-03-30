class Ship
  attr_reader :length, :damage

  def initialize(length)
    @length = length
    @damage = 0
  end

  def attack!
    binding.pry
    @damage += 1
  end

  def is_sunk?
    @damage == @length
  end
end
