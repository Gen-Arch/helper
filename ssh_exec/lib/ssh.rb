require 'net/ssh'
require 'net/scp'

module SSH_EXEC
  class SSH

    attr_accessor :session

    def initialize(args)
      @server = args["server"]
      @user = args["user"]
      @opt = args["opt"]
    end

    def access
      @session = Net::SSH.start(@server, @user, symbolize_keys(@opt))
    end

    private
    def symbolize_keys(hash)
        hash.map{|k,v| [k.to_sym, v] }.to_h
    end
  end
end
