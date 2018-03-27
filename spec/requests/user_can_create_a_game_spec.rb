require 'rails_helper'

describe "User can create a game" do
  describe "When they post to /api/v1/games" do
    let(:player_1) { create(:user) }
    let(:player_2) { create(:user) }

    it "they can start a game" do

      headers = { "CONTENT_TYPE" => "application/json",
                  "X-API-Key" => player_1.active_api_key.id
                }

      payload = { opponent_email: player_2.email }.to_json

      post "/api/v1/games", params: payload, headers: headers

      results = JSON.parse(response.body, symbolize_names: true)

      expect(results[:id]).to be_an Integer
      expect(results[:player_1_board][:rows].count).to eq(4)
      expect(results[:player_2_board][:rows].count).to eq(4)
      expect(results[:player_1][:name]).to eq(player_1.name)
      expect(results[:player_2][:name]).to eq(player_2.name)
    end
  end
end
