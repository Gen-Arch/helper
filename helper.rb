module Helper
    def check(word)
        print "#{word}[y|n]:"
        res =  gets.chomp!
        return res == "y"
    end
    
    def dir_join(file)
      dir = File.join(File.dirname(__FILE__), "data/#{file}")
    end
end
