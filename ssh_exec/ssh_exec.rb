$: << __dir__

require "bundler/setup"
require "lib/ssh"
require "lib/archive"

module SSH_EXEC
  class << self
    def configure(&block)
      instance_eval($block)
    end

    def archive
      @archive ||= SSH_EXEC::Archive.instance
    end

    def get(hostname, &block) 
      session = archive.build(hostname)

      return session unless block
      block.call(session)
    end

    def source(file)
      archive.set_source(file)
    end
  end

end
