require "yaml"
module Serch
  class DB
    def initialize(service, word)
      @db = db_get[service]
      @key = @db.keys
      @add_index = Array.new
      @word = word
    end

    def serch
      comp = Array.new
      
      @key.each do |k|
        @word.each do |w|
          res = @db[k].map.with_index { |e,i| e =~ /#{w}/ ? i : nil }.compact
          @add_index += res
        end
      end

      @add_index.each do |i|
        w = Array.new
        @key.each{|k| w << @db[k][i] }
        comp << w
      end
      
      return comp_array(comp)
    end

    private
      def db_get
        db = open(File.join(File.dirname(__FILE__), "data/db.yml"), "r") {|f| YAML.load(f)}
      end

      def comp_array(ary)
        comp = Array.new

        ary.each{|a| comp << a.join(",")} && comp.uniq!
        return comp
      end
  end
end
