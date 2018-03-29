require 'rails_helper'

describe "users can make shots" do
  describe "As player 1" do
    it "they can fire a hit" do
      player_1 = create(:user)
      player_2 = create(:user)
      player_1_board = Board.new(4)
      player_2_board = Board.new(4)
      sm_ship = Ship.new(2)
      lg_ship = Ship.new(3)

      ShipPlacer.new(board: player_2_board,
        ship: sm_ship,
        start_space: "A1",
        end_space: "A2").run

      game = create(:game,
          player_1: player_1,
          player_2: player_2,
          player_1_board: player_1_board,
          player_2_board: player_2_board)

      headers = {
                  "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_1.api_key.id
                }

      payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: payload, headers: headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:message]).to eq("Your shot resulted in a Hit.")
    end

    it "they can fire a miss" do
      player_1 = create(:user)
      player_2 = create(:user)
      player_1_board = Board.new(4)
      player_2_board = Board.new(4)
      sm_ship = Ship.new(2)
      lg_ship = Ship.new(3)

      ShipPlacer.new(board: player_2_board,
        ship: sm_ship,
        start_space: "A1",
        end_space: "A2").run

      game = create(:game,
          player_1: player_1,
          player_2: player_2,
          player_1_board: player_1_board,
          player_2_board: player_2_board)

      headers = {
                  "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_1.api_key.id
                }

      payload = {target: "B1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: payload, headers: headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:message]).to eq("Your shot resulted in a Miss.")
    end
  end
end
