module Serch
  module Xlogin
    @dir = "#{Dir::pwd}/xloginrc"

    class << self

      def create(*args, **opt, dir="#{Dir::pwd}/xloginrc")
        db = DB.new(args,opt).serch
        list = Array.new
        db.each {|d| list << d.split(",") }
        add(list)
      end

      def add(list)
        File.open(@dir, "w") do |f|
          list.each do |d|
            f.puts("#{d[1]} '#{d[0]}','telnet://:#{d[3]}@#{d[2]}'")
          end
        end
      end

      def configure(&block)
        instance_eval(&block)
      end

      def source(dir)
        @dir = dir
      end

    end
  end
end
