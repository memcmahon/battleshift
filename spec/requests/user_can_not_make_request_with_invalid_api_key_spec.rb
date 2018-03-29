require 'rails_helper'

describe "user must use valid api key when making requests" do
  let(:player_1) { create(:user) }
  let(:player_2) { create(:user) }
  let(:payload) { {opponent_email: player_2.email}.to_json }
  let(:inactive_key) { ApiKey.create!(status: "inactive", user: player_2) }

  it "they can make posts with valid key" do
    headers = { "CONTENT_TYPE" => "application/json",
                "X-API-Key" => player_1.api_key.id
              }

    post "/api/v1/games", params: payload, headers: headers

    expect(response.status).to eq(200)
  end

  it "they can not make posts with invalid key" do
    headers = { "CONTENT_TYPE" => "application/json",
                "X-API-Key" => "invalid key"
              }

    post "/api/v1/games", params: payload, headers: headers

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(401)
    expect(results[:message]).to eq("Unauthorized")
  end

  it "they can not make posts with inactive key" do
    headers = { "CONTENT_TYPE" => "application/json",
                "X-API-Key" => inactive_key
              }

    post "/api/v1/games", params: payload, headers: headers

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(401)
    expect(results[:message]).to eq("Unauthorized")
  end
end
