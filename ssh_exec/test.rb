require "./ssh_exec.rb"

SSH_EXEC.get("casper") do |s|
  resp = s.exec!("ls")
  puts resp
end
