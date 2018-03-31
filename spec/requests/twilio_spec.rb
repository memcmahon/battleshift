require "rails_helper"

describe "as a user" do
  describe "when a shot is fired" do
    it "sends me a text about it" do
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
                  "X-API-Key" => player_1.api_key.id
                }

      payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: payload, headers: headers

      dummy_text = "this is a test"
      text_sent = TwilioTextMessenger.new(dummy_text).call

      expect(text_sent.body).to include("this is a test")
      expect(text_sent.from).to eq("+17206050662")
      expect(text_sent.direction).to eq("outbound-api")
    end
  end
end
