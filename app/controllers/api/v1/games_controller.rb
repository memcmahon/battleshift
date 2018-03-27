class Api::V1::GamesController < ActionController::API
  def show
    if Game.exists?(id: params[:id])
      game = Game.find(params[:id])
      render json: game
    else
      render status: 400
    end
  end
end
