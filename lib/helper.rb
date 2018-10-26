$: << __dir__
require 'helper/colors'
require 'helper/hashsymbols'

module Helper
  class << self
    def confirm(check_word, **opt)
      true_word = ( opt[:true] || /yes|y/ )
      false_word = ( opt[:false] || /no/ )
      while true
        print "#{check_word} (#{true_word.inspect.delete("/")}/#{false_word.inspect.delete("/")}) : "
        case anser = $stdin.gets.strip
        when true_word then return true
        when false_word then return true
        end
      end
    end
  end
end
