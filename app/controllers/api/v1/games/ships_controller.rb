class Api::V1::Games::ShipsController < ApplicationController

  def create
    game = Game.find(params[:game_id])

    if game.player_1.active_api_key.id == request.headers["X-API-KEY"]
      board = game.player_1_board
    elsif game.player_2.active_api_key.id == request.headers["X-API-KEY"]
      board = game.player_2_board
    end
    ship_placer = ShipPlacer.new(board: board, ship: params["ship"], start_space: params["start_space"], end_space: params["end_space"])

    ship_placer.run

    render json: game
  end


end
