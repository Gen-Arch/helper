require 'singleton'
require 'yaml'

module SSH_EXEC
  class Archive
    include Singleton

    attr_accessor :inventry

    def initialize
      @source ||= YAML.load_file(File.join(__dir__, "template/servers.yml"))
      @inventry = Hash.new
    end

    def set_source(file)
      @source = YAML.load_file(file)
    end

    def build
      @source.each do |name, option|
        temp = Hash.new
        option.each do |key, var|
          if key =~ /user|server/
            temp.merge!({key.to_sym => var }) 
          else
            temp[:opt] = (temp[:opt] || {} ).merge({key.to_sym => var})
          end
        end
        @inventry[name] = (@inventry[name] || {} ).merge(temp)
      end
    end

    def session(name)
      build
      source = @inventry[name]
      SSH_EXEC::SSH.new(source[:server], source[:user], source[:opt])
    end

  end
end
