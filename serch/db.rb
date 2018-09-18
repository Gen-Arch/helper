require "yaml"

module Serch
  class DB
    include Helper

    def initialize(*args,**opt)
      @word = args.to_a
      @noword = opt[:noword].to_a
      @service = opt[:service]
      @db = opt[:service] ? db_get.select{|k, v| k == opt[:service] } : db_get
      @add_index = Array.new
      @delete_index = Array.new
    end

    def create_db
      dir = File.open(dir_join("db.yml"), "w")
      YAML.dump(Evlan.new.get, dir)
      dir = File.open(dir_join("db.yml"), "a")
      YAML.dump(Uno.new.get, dir)
    end

    def serch
      comp = Array.new

      @word.each do |w|
        res = @db[k].map.with_index { |e,i| e =~ /#{w}/ ? i : nil }.compact
        @add_index += res
      end
      @noword.each do |w|
        res = @db[k].map.with_index { |e,i| e =~ /#{w}/ ? i : nil }.compact
        @delete_index += res
      end
      @add_index.each{|i| @add_index.delete(i) if @delete_index.include?(i) }

      @add_index.each do |i|
        w = Array.new
        @key.each{|k| w << @db[k][i] }
        comp << w

        return comp_array(comp)
      end
    end

    private
    def db_get
      db = open(File.join(__dir__, "data/db.yml"), "r") {|f| YAML.load(f)}
    end

    def comp_array(ary)
      comp = Array.new

      ary.each{|a| comp << a.join(",")} && comp.uniq!
      return comp
    end
  end
end
