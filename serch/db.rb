require "yaml"
require "ostruct"

module Serch
  class DB
    def initialize(*args,**opt)
      @config = opt_analysis(args,opt)
      @add_index = Array.new
    end

    def serch
      comp = Array.new
      
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
    def opt_analysis(args,opt)
        config = OpenStruct.new
        config.word = args.to_a
        config.noword = opt[:noword].to_a
        config.service = opt[:service]
        config.db = opt[:service] ? db_get[opt[:service]] : db_get
        return config
    end

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
