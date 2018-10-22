module Analize
  def confirm(check_word, regexp=/yes|y/)
    print check_word
    input = gets.chomp!
    return input =~ regexp
  end
end
