require "yaml"

module Serch
  class DB

    def initialize(*args,**opt)
      @word = args.to_a
      @noword = opt[:noword].to_a
      @db = db_get
      @add_index = Array.new
      @delete_index = Array.new
    end


    def serch
      comp = Array.new
      @db.keys do |k|
        @word.each do |w|
          res = @db[k].map.with_index { |e,i| e =~ /#{w}/ ? i : nil }.compact
          @add_index += res
        end
        @noword.each do |w|
          res = @db[k].map.with_index { |e,i| e =~ /#{w}/ ? i : nil }.compact
          @delete_index += res
        end
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
      db = YAML.load_file(File.join(Serch::DIR,"db.yml"))
    end

    def comp_array(ary)
      comp = Array.new

      ary.each{|a| comp << a.join(",")} && comp.uniq!
      return comp
    end
  end
end
