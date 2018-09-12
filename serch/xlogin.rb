module Serch
  module Xlogin

    class << self

      def create(service, word, dir="#{Dir::pwd}/xloginrc")
        db = Serch::DB.new(service,word).serch
        aplist = Array.new
        db.each {|d| aplist << d.split(",") }
        File.open(dir, "w") do |f|
          aplist.each{ |d| f.puts("#{type_check(d[1])} '#{d[0]}','telnet://ccnc:#{d[3]}@#{d[2]}'") }
        end
      end

      def type_check(type)
        case type
        when /26010/
          return "ap26k"
        when /18020/
          return "ap18k"
        when /16012/
          return "ap16k"
        when /8007/
          return "ap8k"
        when /6048/, /6148/
         return "ap6k"
        else
         return type
        end
      end
    end

  end
end
