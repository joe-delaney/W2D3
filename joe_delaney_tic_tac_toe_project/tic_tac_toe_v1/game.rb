require_relative 'board.rb'
require_relative 'human_player.rb'

class Game

    def initialize(mark1, mark2)
        @player_1 = HumanPlayer.new(mark1)
        @player_2 = HumanPlayer.new(mark2)
        @board = Board.new
        @current_player = @player_1
    end

    def switch_turn
        if @current_player == @player_1
            @current_player = @player_2 
        else
            @current_player = @player_1
        end
    end

    def play
        while @board.empty_positions?
            @board.print
            position = @current_player.get_position
            valid_input = false
            while !valid_input
                if @board.place_mark(position, @current_player.mark)
                    valid_input = true 
                else
                    position = @current_player.get_position
                end
            end
            
            if @board.win?(@current_player.mark)
                puts (@current_player.mark.to_s + " has won the game! Congrats!")
                return 
            else
                switch_turn
            end
        end
        puts 'It\'s a draw!'
    end
end