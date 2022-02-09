class Code
    POSSIBLE_PEGS = {
      "R" => :red,
      "G" => :green,
      "B" => :blue,
      "Y" => :yellow
    }

    attr_reader :pegs

    def self.valid_pegs?(chars)
      chars.all? {|char| POSSIBLE_PEGS.has_key?(char.upcase)}
    end

    def self.random(n)
      new_pegs = Array.new(n)
      keys = POSSIBLE_PEGS.keys
      (0...new_pegs.length).each {|i| new_pegs[i] = keys[rand(0...keys.length)]}
      Code.new(new_pegs)
    end

    def self.from_string(str)
      Code.new(str.split(""))
    end

    def initialize(chars)
      if !Code.valid_pegs?(chars)
        raise "Invalid pegs entered"
      else
        @pegs = chars.map {|char| char.upcase}
      end
    end

    def [](idx)
      @pegs[idx]
    end
    
    def length 
      @pegs.length 
    end

    def num_exact_matches(guess)
      count = 0
      (0...guess.length).each {|i| count += 1 if guess[i] == @pegs[i]}
      count
    end

    def num_near_matches(guess)
      #Make copies of the guess and the answer pegs
      guess_copy = guess.pegs.dup 
      peg_copy = @pegs.dup
      
      #Remove exact matches
      (0...guess_copy.length).each do |i|
        if guess_copy[i] == peg_copy[i]
          guess_copy[i] = nil
          peg_copy[i] = nil
        end
      end
      guess_copy.delete(nil)
      peg_copy.delete(nil)

      #Count near matches and then remove them from answer pegs to avoid double counting
      count = 0
      (0...guess_copy.length).each do |i|
        if peg_copy.include?(guess_copy[i])
          count += 1
          peg_copy.delete_at(peg_copy.index(guess_copy[i]))
        end
      end
      count
    end

    def ==(code)
      self.length == code.length && num_exact_matches(code) == code.length
    end
end
