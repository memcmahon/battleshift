class Api::V1::GamesController < ApiController
  before_action :verify_opponent, only: [:create]

  def show
    if Game.exists?(id: params[:id])
      game = Game.find(params[:id])
      render json: game
    else
      render status: 400
    end
  end

  def create
    player_1 = User.find(ApiKey.find(request.headers["X-API-Key"]).user_id)
    player_2 = User.find_by(email: params[:opponent_email])

    game = Game.new(player_1: player_1, player_2: player_2,
                    player_1_board: Board.new(4), player_2_board: Board.new(4))

    game.save

    render json: game
  end

  private
    def verify_opponent
      unless User.find_by(email: params[:opponent_email]).activated
        render json: {message: "The opponent you have chosen is not an active user."}, status: 400
      end
    end
end
