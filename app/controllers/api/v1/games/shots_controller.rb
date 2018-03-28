class Api::V1::Games::ShotsController < ApiController
  def create
    game = Game.find(params[:game_id])

    if request.env["HTTP_X_API_KEY"] == game.player_1.api_key.id
      player = game.player_1
    elsif request.env["HTTP_X_API_KEY"] == game.player_2.api_key.id
      player = game.player_2
    end

    turn_processor = TurnProcessor.new(game, params[:shot][:target], player)

    turn_processor.run!
    render json: game, message: turn_processor.message
  end
end
