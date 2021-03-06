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
        result = Shooter.new(board: opponent_board, target: target).fire!
        @messages << "Your shot resulted in a #{result}."
        turn_setter
        you_sunk_my_battleship
        game_over?
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

    def you_sunk_my_battleship
      if shipwreck?
        @messages << "Battleship sunk."
      else
        @messages
      end
    end

    def shipwreck?
      if ship_there?
        ship_there?.is_sunk?
      end
    end

    def ship_there?
      opponent_board.board.flatten.map do |row|
        row[@target]
      end.compact.first.contents
    end

    def all_spaces
      opponent_board.board.flatten.map do |row|
        row.values.first
      end
    end

    def all_ships
      all_spaces.map do |space|
        space.contents
      end.compact
    end

    def all_sunk?
      all_ships.map do |ship|
        ship.is_sunk?.to_s
      end.uniq
    end

    def game_over?
      if all_sunk?.include?("false")
        @messages
      else
        @messages << "Game over."
        game.winner = @player.email
      end
    end

    def opponent_board
      if @player == game.player_1
        game.player_2_board
      else
        game.player_1_board
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

end
