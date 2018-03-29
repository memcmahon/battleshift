class TurnProcessor
  def initialize(game, target, player, player_role)
    @game   = game
    @target = target
    @player = player
    @player_role = player_role
    @messages = []
  end

  def run!
    begin
      attack_opponent
      # ai_attack_back
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent
    if game.current_turn == @player_role
      result = Shooter.fire!(board: opponent_board, target: target)
      @messages << "Your shot resulted in a #{result}."
      turn_setter
    else
      raise InvalidAttack.new("Invalid move. It's your opponent's turn")
    end
  end

  def turn_setter
    if game.current_turn == "challenger"
      game.player_1_turns += 1
      game.current_turn = "opponent"
    else
      game.player_2_turns += 1
      game.current_turn = "challenger"
    end
  end

  # def ai_attack_back
  #   result = AiSpaceSelector.new(player.board).fire!
  #   @messages << "The computer's shot resulted in a #{result}."
  #   game.player_2_turns += 1
  # end

  # def player
  #   Player.new(game.player_1_board)
  # end

  def opponent_board
    if @player == game.player_1
      game.player_2_board
    else
      game.player_1_board
    end
  end
end
