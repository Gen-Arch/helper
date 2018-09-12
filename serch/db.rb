require "yaml"
module Serch
  module DB
    class << self
      def serch(service, word)
        db = db_get[service]
        key = db.keys
        res_index = Array.new
        comp = Array.new

        key.each do |k|
          res = db[k].map.with_index { |e,i| e =~ /#{word}/ ? i : nil }.compact
          res_index += res
        end

        res_index.each do |i|
          w = Array.new
          key.each{|k| w << db[k][i] }
          comp << w
        end
        
        return comp_array(comp)
      end

      def db_get
        db = open(File.join(File.dirname(__FILE__), "data/db.yml"), "r") {|f| YAML.load(f)}
      end

      def comp_array(ary)
        temp = Array.new
        comp = Array.new

        ary.each{|a| temp << a.join(",")} && temp.uniq!
        temp.each{|v| comp << v.split(",")}
        return comp
      end

    end
  end
end
