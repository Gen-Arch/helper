require "color_echo/get"

module Kernel
  colors = :yellow, :cyan, :blue, :red, :white, :h_white

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
