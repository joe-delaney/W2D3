class Board
  
    attr_reader :size

    def self.print_grid(grid)
        grid.each do |row|
            puts row.join(" ")
        end
    end

    def initialize(n)
        @grid = Array.new(n) {Array.new(n, :N)}
        @size = n * n
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end

    def num_ships
        @grid.flatten.count {|ele| ele == :S}
    end

    def attack(position)
        if self[position] == :S 
            self[position] = :H 
            puts 'you sunk my battleship!'
            return true 
        else
            self[position] = :X 
            return false 
        end
    end

    def place_random_ships
        total_ships = @size * 0.25

        while self.num_ships < total_ships
            row = rand(0...@grid.length)
            col = rand(0...@grid[row].length)
            rand_position = [row, col]
            self[rand_position] = :S 
        end
    end

    def hidden_ships_grid
        @grid.map do |row|
            row.map do |ele|
                if ele == :S
                    :N 
                else
                    ele 
                end
            end
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
