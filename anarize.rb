module Anarize
    def check(word)
        print "#{word}[y|n]:"
        res gets.chomp!
        return res == "y"
    end
end
