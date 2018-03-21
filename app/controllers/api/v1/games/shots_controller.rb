module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])

          player = Player.new(game.player_1_board)
          computer = Player.new(game.player_2_board)

          turn_result = []

          # player shoots
          result_1 = Shooter.fire!(board: computer.board, target: params[:shot][:target])
          turn_result << {player_1: "Shot resulted in a #{result_1}"}
          game.player_1_turns += 1


          # computer shoots
          result_2 = AiSpaceSelector.new(player.board).fire!
          turn_result << {player_2: "Shot resulted in a #{result_2}"}
          game.player_2_turns += 1

          # should set a message with the status of the attack here
          game.history << turn_result

          # save the state from the above moves
          game.save!
          render json: game
        end
      end
    end
  end
end
