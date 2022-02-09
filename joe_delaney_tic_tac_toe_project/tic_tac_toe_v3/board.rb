class Board
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, '_')}
    end

    def valid?(position)
        row = position[0]
        col = position[1]
        if row < 0 || row >= @grid.length || col < 0 || col >= @grid[row].length
            return false
        end
        return true
    end

    def empty?(position)
        self[position] == '_'
    end

    def place_mark(position, mark)
        if !valid?(position)
            puts "Invalid position entered"
            return false
        elsif !empty?(position)
            puts 'Selected spot is taken. Choose again.'
            return false
        else
            self[position] = mark
            return true
        end
    end

    def [](position)
        row = position[0]
        col = position[1]
        @grid[row][col]
    end

    def []=(position, ele)
        row = position[0]
        col = position[1]
        @grid[row][col] = ele
    end

    def print
        @grid.each do |row|
            p row.join(" ")
        end
        return nil
    end

    def win_row?(mark)
        @grid.each {|row| return true if row.all? {|ele| ele == mark}}
        return false
    end

    def win_col?(mark)
        (0...@grid.length).each do |i|
            column = []
            (0...@grid[i].length).each do |j|
                column << @grid[j][i]
            end
            return true if column.all? {|ele| ele == mark}
        end
        return false
    end

    def win_diagonal?(mark)
        forward_diag = []
        backward_diag = []

        (0...@grid.length).each do |i|
            forward_diag << @grid[i][i]
            backward_diag << @grid[i][@grid.length-i-1]
        end

        if forward_diag.all? {|ele| ele == mark} || backward_diag.all? {|ele| ele == mark}
            return true
        else 
            return false
        end
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.flatten.count {|ele| ele == '_'} > 0
    end

    def legal_positions
        legal_positions = []
        (0...@grid.length).each do |row|
            (0...@grid[row].length).each do |col|
                legal_positions << [row, col] if empty?([row, col])
            end
        end
        legal_positions
    end

end