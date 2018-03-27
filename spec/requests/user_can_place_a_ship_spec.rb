require "rails_helper"

describe "user can place a ship" do
  describe "when they post to /api/v1/games/:game_id/ships" do
    it "places a ship based on payload" do
      conn = Faraday.new("http://localhost:3000/api/v1/games/#{Game.last.id}/ships") do |faraday|
        faraday.headers["X-API-Key"] = ENV["TEST_PLAYER_1_API_KEY"]
        faraday.adapter Faraday.default_adapter
      end

      ship_1_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }.to_json

      request = conn.post do |req|
        req.headers["CONTENT_TYPE"] = "application/json"
        req.body = ship_1_payload
      end

      respone = JSON.parse(request.body, symbolize_names: true)



    end
  end
end
