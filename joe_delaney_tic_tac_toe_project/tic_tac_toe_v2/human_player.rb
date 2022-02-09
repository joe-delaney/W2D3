class HumanPlayer

    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position
        digits = "0123456789"
        valid_input = false
        puts mark.to_s + "'s turn!"
        puts "Enter a position on the board (Example: \'1 2\')"
        
        while !valid_input
            position = gets.chomp
            if position.length > 3
                puts 'Invalid input! Too many characters entered, try again:'
            elsif position.length < 3
                puts 'Invalid input! Not enough characters entered, try again:'
            elsif !digits.include?(position[0]) || !digits.include?(position[2]) || position[1] != ' '
                puts 'Invalid input! Enter two numbers with a single space between them, try again: '
            else
                valid_input = true 
            end
        end

        [position[0].to_i, position[2].to_i]
    end
end