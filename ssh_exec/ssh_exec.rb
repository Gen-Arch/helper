$: << __dir__

require "ssh_exec/ssh"
require "ssh_exec/archive"

module SSH_EXEC
  class << self
    def configure(&block)
      instance_eval(&block)
    end

    def archive
      @archive ||= SSH_EXEC::Archive.instance
    end

    def server_list
      archive.build
      archive.inventry.keys
    end

    def get(hostname, &block) 
      session = archive.session(hostname)

      return session unless block_given?
      block.call(session)
    end

    def source(file)
      archive.set_source(file)
    end
  end

end
