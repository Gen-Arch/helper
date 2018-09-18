$: << __dir__

require "serch/evlan"
require "serch/db"
require "serch/xlogin"
require "serch/uno"

module Serch
  DIR = File.join(__dir__, "serch/data")

  class << self
    def create_db
      dir = File.join(DIR,"db.yml")
      file = File.open(dir, "w")
      YAML.dump(Evlan.new.get, file)
      file = File.open(dir, "a")
      YAML.dump(Uno.new.get, file)
    end
  end

end
