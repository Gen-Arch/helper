module Analize
  def confirm(check_word, regexp)
    print check_word
    input = gets.chomp!
    return input =~ regexp
  end
end
