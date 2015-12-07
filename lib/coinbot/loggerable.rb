module Coinbot
  module Loggerable
    def info(*args)
      puts args.join(' ')
    end

    def debug(*args)
      info(*args) if ENV['DEBUG']
    end
  end
end
