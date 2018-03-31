require 'rails_helper'

describe "Only active users can create games" do
  describe "as an active user" do
    describe "When they post to /api/v1/games" do
      let(:player_1) { create(:user) }
      let(:player_2) { create(:user) }

      it "they can start a game" do

        headers = { "CONTENT_TYPE" => "application/json",
                    "X-API-Key" => player_1.api_key.id
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

  describe "as an inactive user" do
    describe "they post to /api/v1/games" do
      let(:player_1) { create(:user, activated: false) }
      let(:player_2) { create(:user) }

      it "they can't start a game" do

        headers = { "CONTENT_TYPE" => "application/json",
                    "X-API-Key" => player_1.api_key.id
                  }

        payload = { opponent_email: player_2.email }.to_json

        post "/api/v1/games", params: payload, headers: headers

        results = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(401)
        expect(results[:message]).to include("your account is not active, please click activation link in email")
      end
    end
  end
end
