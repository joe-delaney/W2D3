require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'

class Game

    def initialize(n, player_hash)
        @players = []
        player_hash.each do |mark, computer|
            if computer
                @players << ComputerPlayer.new(mark)
            else
                @players << HumanPlayer.new(mark)
            end
        end
        @board = Board.new(n)
        @current_player = @players[0]
    end

    def switch_turn
        @players = @players.rotate(1)
        @current_player = @players[0]
    end

    def play
        while @board.empty_positions?
            @board.print
            position = @current_player.get_position(@board.legal_positions)
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