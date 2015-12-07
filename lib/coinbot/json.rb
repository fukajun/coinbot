require 'hashie'

module Coinbot
  module JSON
    def parse(json_string)
      Hashie::Mash.new(::JSON.parse(json_string))
    end
  end
end
