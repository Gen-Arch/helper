require 'singleton'
require 'yaml'

module SSH_EXEC
  class Archive
    include Singleton

    def initialize
      @source ||= YAML.load_file(File.join(__dir__,"template/servers.yml"))
      @inventry = Hash.new
    end

    def set_source(file)
      @source ||= YAML.load_file(file)
    end

    def build(hostname)
      opt = @source[hostname]
      ssh = SSH_EXEC::SSH.new(opt)
      ssh.access
    end

  end
end
