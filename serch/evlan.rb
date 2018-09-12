require "yaml"
require "csv"

module Serch
  class Evlan
    def initialize
      @list_csv = dir_join("evlan_hostlist.csv")
      @ver_csv = dir_join("ver.csv")
      @yaml = File.open(dir_join("db.yml"), "w")
      @evlandb = db_create
    end

    def get
      @evlandb
    end
    
    def set_yaml
      db = { "evlan" => @evlandb } 
      YAML.dump(db, @yaml)
    end

    private
      def dir_join(file)
        dir = File.join(File.dirname(__FILE__), "data/#{file}")
      end

      def db_create
        host = Array.new
        type = Array.new
        ip = Array.new
        ver = Array.new
        pass = Array.new
        
        #csv_sample => "sir-ics-104","Apresia 8007","1310611001","10.124.205.141","ISP-九州・中国2","inet","inet","kanto",\N
        CSV.read(@list_csv).each do |data|
          host << data[0]
          type << data[1]
          ip << data[3]
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
          "pass" => pass,
          "ver" => ver
        }
        return db
      end
  end
end
