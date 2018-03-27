class Game < ApplicationRecord
  attr_accessor :messages

  belongs_to :player_1, class_name: "User"
  belongs_to :player_2, class_name: "User"

  enum current_turn: ["challenger", "computer"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true
end
