require "yaml"
require "csv"

module Serch
  class Evlan

    def initialize
      @dir
      @list_csv = File.join(Serch::DIR, "evlan_hostlist.csv")
      @ver_csv = File.join(Serch::DIR, "ver.csv")
      @evlandb = db_create
    end

    def get
      @evlandb
    end

    private
      def db_create
        host = Array.new
        type = Array.new
        ip = Array.new
        ver = Array.new
        id = Array.new
        pass = Array.new
        
        #csv_sample => "sir-ics-104","Apresia 8007","1310611001","10.124.205.141","ISP-九州・中国2","inet","inet","kanto",\N
        CSV.read(@list_csv).each do |data|
          next unless type_check(data[1])
          host << data[0]
          type << type_check(data[1])
          ip << data[3]
          id << "ccnc"
          pass << data[6]
        end

        #csv_sample => "sir-ics-104","1.08.175"
        CSV.read(@ver_csv).each do |node,version|
          host.each_with_index{|v, i| ver[i] = version if node == v}
        end
        db = {
          "host" => host,
          "type" => type,
          "ip" => ip,
          "id" => id,
          "pass" => pass,
          "ver" => ver
        }
        return db
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
         return false
        end
      end
  end
end
