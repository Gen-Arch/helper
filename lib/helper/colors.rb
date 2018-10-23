require "color_echo/get"

module Colors
  colors = [
    :yellow, :cyan, :blue, :red, :white, :black, :green, :magenta, :gray,
    :h_yellow, :h_cyan, :h_blue, :h_red, :h_white, :h_green, :h_magenta, :h_gray,
  ] 

  colors.each do |color|
    define_method(color) do |check=nil, check_color=:red|
      if check.nil?
        CE.fg(color).get(self)
      else
        check = Array(check) unless check.is_a?(Array)
        CE.fg(color).pickup(check, check_color).get(self)
      end
    end
  end
end

String.send(:prepend, Colors)
