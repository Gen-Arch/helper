require "yaml"

module Serch
  class DB
    def initialize(*args,**opt)
      @word = args.to_a
      @noword = opt[:noword].to_a
      @service = opt[:service]
      @db = opt[:service] ? db_get[opt[:service]] : db_get
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
