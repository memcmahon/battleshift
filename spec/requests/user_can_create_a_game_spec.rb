require 'rails_helper'

describe "User can create a game" do
  describe "When they visit /api/v1/games" do
    it "they can start a game" do
      megan = create(:user, email: "mcmahon.meganelizabeth@gmail.com", activated: true)
      cam = create(:user, email: "wlcjohnson@gmail.com", activated: true)

      conn = Faraday.new("http://localhost:3000/api/v1/games") do |faraday|
        # binding.pry
        faraday.headers["X-API-Key"] = megan.active_api_key.id
        faraday.adapter Faraday.default_adapter
      end

      payload = ({ opponent_email: "wlcjohnson@gmail.com" }).to_json

      request = conn.post do |req|
        req.headers["CONTENT_TYPE"] = "application/json"
        req.body = payload
      end

      binding.pry

      response = JSON.parse(request.body, symbolize: true)

      expect(response[:id]).to eq(Game.last.id)
    end
  end
end
