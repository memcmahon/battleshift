require "rails_helper"

describe "user can place a ship" do
  describe "when they post to /api/v1/games/:game_id/ships" do
    let(:player_1) { create(:user) }
    let(:player_2) { create(:user) }

    let(:game)     { create(:game, player_1: player_1,
                            player_2: player_2, player_1_board: Board.new(4),
                            player_2_board: Board.new(4)) }

    xit "places a ship based on payload" do

      headers = { "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_1.active_api_key.id
                }

      ship_1_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }.to_json

      post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: headers

      results = JSON.parse(request.body, symbolize_names: true)


    end
  end
end
