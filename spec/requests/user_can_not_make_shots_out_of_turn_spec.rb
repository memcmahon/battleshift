require 'rails_helper'

describe "users can not make shots out of turn" do
  describe "As player 2" do
    it "they try to go first" do
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
                  "X-API-Key" => player_2.api_key.id
                }

      payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: payload, headers: headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(result[:message]).to eq("Invalid move. It's your opponent's turn")
    end

    it "they can not make a shot after game is over" do
      player_1 = create(:user)
      player_2 = create(:user)
      player_1_board = Board.new(4)
      player_2_board = Board.new(4)

      game = create(:game, player_1: player_1, player_2: player_2,
                    player_1_board: player_1_board, player_2_board: player_2_board,
                    winner: "player_1")

      headers = {
                  "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_2.api_key.id
                }

      payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: payload, headers: headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(result[:message]).to include("Invalid move. Game over.")
      expect(result[:winner]).to eq("player_1")
    end
  end
end
