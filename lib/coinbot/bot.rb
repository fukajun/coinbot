require_relative './clients/coincheck'
require_relative './exchange'
require_relative './trader'

module Coinbot
  class Bot
    def initialize
      key    = ENV['COINCHECK_API_KEY']
      secret = ENV['COINCHECK_SECRET_KEY']
      client = Coinbot::Clients::Coincheck.new
      @exchange = Coinbot::Exchange.new(client)
      @trader = Coinbot::Trader.new(@exchange)
      @stop = false
    end

    def run
      loop do
        if @stop
          @exchange.cancel_all
          return
        end
        @exchange.sync
        @trader.deal
      end
    end

    def stop
      @stop = true
    end
  end
end
