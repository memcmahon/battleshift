class Api::V1::Games::ShotsController < ApiController
  before_action :game_player?
  
  def create
    game = Game.find(params[:game_id])

    if request.env["HTTP_X_API_KEY"] == game.player_1.api_key.id
      player = game.player_1
      player_role = "challenger"
    elsif request.env["HTTP_X_API_KEY"] == game.player_2.api_key.id
      player = game.player_2
      player_role = "opponent"
    end

    turn_processor = TurnProcessor.new(game, params[:shot][:target], player, player_role)

    turn_processor.run!

    if turn_processor.message.include?("Invalid")
      render json: game, status: 400, message: turn_processor.message
    else
      render json: game, message: turn_processor.message
    end
  end

  private
    def game_player?
      game = Game.find(params[:game_id])

      unless [game.player_1.api_key.id, game.player_2.api_key.id].include?(request.headers["X-API-KEY"])
        render json: {message: "You are not a player in this game!"}, status: 401
      end
    end
end
