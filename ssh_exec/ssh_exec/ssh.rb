require "net/ssh"
require "net/scp"

module SSH_EXEC
  class SSH
    def initialize(host, user, **opt)
      @session = Net::SSH.start(host, user, **opt)
    end

    def exec(cmd, regexp=/.*/)
      @session.exec!(cmd)[regexp]
    end

    def scp(src, dst)
      @session.scp.download! src, dst
    end
    
  end
end
