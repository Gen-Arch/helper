require 'yaml'
require 'socket'
require 'helper'

module Serch
  class Uno
    include Helper
    def initialize
      @uno_db = db_create
    end

    def get
      @uno_db
    end

    private
    def db_create 
      res = {
        "host" => Array.new,
        "ip" => Array.new,
        "pass" => Array.new,
        "type" => Array.new
      }
      yml = YAML.load(dir_join("list.yml"))

      yml.each do |y|
        next unless host_chack(y)

        begin
          res["ip"] << IPSocket.getaddress("#{y}")
          res["host"] << y[/^(.*)\..*/, 0]
          res["pass"] << "Sak1&wak7!"
          res["type"] << host_chack(y)
        rescue => e
          next
        end
      end
      return res
    end

    def host_chack(host)
      case host
      when /^padao/
        return "cat"
      when /^blomf/,/^ascai/, /^arecai/, /^bromi/, /^arebi/, /asgi/, /^beci/, /^l2gi/, /^l3gi/, /^voigi/, /^glogi/
        return "asr9k"
      when /^gigio/
        return "gsr"
      when /^radao/
        return "vxr"
      when /^jucae/, /^cdnbe/, /^agae/, /^addbe/, /^natge/
        return "mx"
      when /^fsrh/
        return "srx"
      when /^rro/
        return "r30"
      when /^alcao/, /^alcoo/, /^mvgo/, /^l2go/
        return "alcatel"
      when /^xeu/
        return "xmr"
      when /^ipsgd/
        return "fx"
      when /^vlre/
        return "m10i"
      when /^xec/
        return "ap15k"
      else
        return false
      end
    end
  end 
