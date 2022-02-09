class ComputerPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        rand_position = rand(0...legal_positions.length)
        computer_position = legal_positions[rand_position]
        print ("Computer " + @mark.to_s + " chose position: ")
        print computer_position
        print "\n"
        computer_position
    end
end