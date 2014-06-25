module Capistrano
  class Version
    MAJOR = 2
    MINOR = 15
    PATCH = 20

    def self.to_s
      "#{MAJOR}.#{MINOR}.#{PATCH}"
    end
  end
end
