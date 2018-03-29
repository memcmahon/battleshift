require "rails_helper"

describe "user can place a ship" do
  describe "when they post to /api/v1/games/:game_id/ships" do
    let(:player_1) { create(:user) }
    let(:player_2) { create(:user) }

    let(:game)     { create(:game, player_1: player_1,
                            player_2: player_2, player_1_board: Board.new(4),
                            player_2_board: Board.new(4)) }

    it "places a ship based on payload" do

      player_1_headers = {
                  "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_1.api_key.id
                }

      player_2_headers = {
                  "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_2.api_key.id
                }

      ship_1_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }.to_json

      ship_2_payload = {
        ship_size: 2,
        start_space: "B1",
        end_space: "C1"
      }.to_json

      post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: player_1_headers

      results = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(200)
      expect(results[:message]).to eq("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")

      post "/api/v1/games/#{game.id}/ships", params: ship_2_payload, headers: player_1_headers

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(results[:message]).to eq("Successfully placed ship with a size of 2. You have 0 ship(s) to place.")

      #opponent ship placement
      post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: player_2_headers

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(results[:message]).to eq("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")

      post "/api/v1/games/#{game.id}/ships", params: ship_2_payload, headers: player_2_headers

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(results[:message]).to eq("Successfully placed ship with a size of 2. You have 0 ship(s) to place.")
    end
  end
end
