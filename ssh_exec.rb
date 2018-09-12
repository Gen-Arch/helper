require 'net/ssh'

module SSH_EXEC
  class << self
    def configure(&block)
      instance_eval($block)
    end
    def start(host, if_id , fqdn)
      f = nil
      fqdn.each do |line|
        f = line if line =~ /#{host}/
      end
      ssh(f, if_id) unless f.nil?
      self
    end

    def ssh(host, if_id)
      server = "203.139.163.172" #donald server
      Net::SSH.start(server, "tos.ito", :password => 'ts011h216') do |ssh|
        cmd = "snmpwalk -t 30 -v 2c -c kokyombgrt #{host} ifAlias.#{if_id}"
        resp = ssh.exec!(cmd)
        result = resp =~ /to_CE/ ? "O" : "X"
        puts "#{result} : #{host}"
        puts "=> #{resp}"
      end
    end
  end
end
