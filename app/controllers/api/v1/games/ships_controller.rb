class Api::V1::Games::ShipsController < ActionController::API

  def create
    game = Game.find(params[:game_id])

    if game.player_1.api_key.id == request.headers["X-API-KEY"]
      board = game.player_1_board
    elsif game.player_2.api_key.id == request.headers["X-API-KEY"]
      board = game.player_2_board
    end

    ship_placer = ShipPlacer.new(board: board, ship: Ship.new(params["ship_size"]), start_space: params["start_space"], end_space: params["end_space"])

    message = ship_placer.run
    render json: game, message: message
  end
end
