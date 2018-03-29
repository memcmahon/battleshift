require "rails_helper"

describe "as a user" do
  describe "as player 1" do
    it "i can sink a ship" do
      player_1 = create(:user)
      player_2 = create(:user)
      player_1_board = Board.new(4)
      player_2_board = Board.new(4)
      sm_ship = Ship.new(2)
      lg_ship = Ship.new(3)

      ShipPlacer.new(
        board: player_1_board,
        ship: sm_ship,
        start_space: "B1",
        end_space: "C1"
      ).run

      ShipPlacer.new(
        board: player_1_board,
        ship: lg_ship,
        start_space: "A1",
        end_space: "A3"
      ).run

      ShipPlacer.new(
        board: player_2_board,
        ship: sm_ship,
        start_space: "B1",
        end_space: "C1"
      ).run

      ShipPlacer.new(
        board: player_2_board,
        ship: lg_ship,
        start_space: "A1",
        end_space: "A3"
      ).run

      game = create(
          :game,
          player_1: player_1,
          player_2: player_2,
          player_1_board: player_1_board,
          player_2_board: player_2_board
        )

      player_1_headers = {
                  "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_1.api_key.id
                }

      player_2_headers = {
                  "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_2.api_key.id
                }

      #player 1 ship 1 shot 1
      payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_1_headers

      #player 2 ship 1 shot 1
      payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_2_headers

      #player 1 ship 1 shot 2 => sink ship
      payload = {target: "C1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_1_headers

      #player 2 ship 1 shot 2
      payload = {target: "C1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_2_headers

      #player 1 ship 2 shot 1
      payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_1_headers

      #player 2 ship 2 shot 1
      payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_2_headers

      #player 1 ship 2 shot 2
      payload = {target: "A2"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_1_headers

      #player 2 ship 2 shot 2
      payload = {target: "A2"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_2_headers

      #player 1 ship 2 shot 3 => game over
      payload = {target: "A3"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: payload, headers: player_1_headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:message]).to eq("Your shot resulted in a Hit. Battleship sunk. Game over.")
    end
  end
end
