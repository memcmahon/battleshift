require 'rails_helper'

describe "users can make shots" do
  let(:player_1) { create(:user) }
  let(:player_2) { create(:user) }
  let(:player_1_board)   { Board.new(4) }
  let(:player_2_board)   { Board.new(4) }
  let(:sm_ship) { Ship.new(2) }
  let(:lg_ship) { Ship.new(3) }
  let(:game)    {
    create(:game,
      player_1: player_1,
      player_2: player_2,
      player_1_board: player_1_board,
      player_2_board: player_2_board
    )
  }

  describe "As player 1" do
    it "they can fire a hit" do
      ShipPlacer.new(board: player_2_board,
        ship: sm_ship,
        start_space: "A1",
        end_space: "A2").run

      headers = {
                  "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_1.api_key.id
                }

      payload = {target: "A1"}.to_json

      post post "/api/v1/games", params: payload, headers: headers

    end
  end
end
