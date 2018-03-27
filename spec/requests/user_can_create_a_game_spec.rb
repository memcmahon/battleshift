require 'rails_helper'

describe "User can create a game" do
  describe "When they visit /api/v1/games" do
    it "they can start a game" do
      conn = Faraday.new("http://localhost:3000/api/v1/games") do |faraday|
        faraday.headers["X-API-Key"] = ENV["TEST_PLAYER_1_API_KEY"]
        faraday.adapter Faraday.default_adapter
      end

      payload = ({ opponent_email: "wlcjohnson@gmail.com" }).to_json

      request = conn.post do |req|
        req.headers["CONTENT_TYPE"] = "application/json"
        req.body = payload
      end


      response = JSON.parse(request.body, symbolize_names: true)

      expect(response[:id]).to be_an Integer
      expect(response[:player_1_board][:rows].count).to eq(4)
      expect(response[:player_2_board][:rows].count).to eq(4)
      expect(response[:player_1][:name]).to eq("Megan")
      expect(response[:player_2][:name]).to eq("Cam")
    end
  end
end
