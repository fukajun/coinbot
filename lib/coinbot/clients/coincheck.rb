require 'ruby_coincheck_client'
require_relative '../json'

module Coinbot
  module Clients
    class Coincheck
      include Coinbot::JSON
      REQUEST_INTERVAL_SEC = 0.8

      def ticker
        request(:read_ticker)
      end

      def order_books
        books = request(:read_order_books, response.body)
        [asks(books), bids(books)]
      end

      def my_orders
        request(:read_orders)
      end

      def transactions
        request(:read_transactions)
      end

      def buy(rate, amount)
        request(:create_orders, rate, amount, 'buy')
      end

      def sell(rate, amount)
        request(:create_orders, rate, amount, 'sell')
      end

      def delete_orders(id)
        request(:delete_orders, id)
      end

      private
        def asks(books)
          books.asks
            .map{ |data| [ data[0].to_f, data[1].to_f ] }
            .sort{|a, b| a[0] <=> b[0] }
            .take(5)
        end

        def bids(books)
          books.bids
            .map{ |data| [ data[0].to_f, data[1].to_f ] }
            .sort {|a, b| a[0] <=> b[0] }
            .last(5)
            .reverse
        end

        def initialize(key, secret)
          @client = CoincheckClient.new(key, secret)
        end

        def client
          @client
        end

        def request(method, *args)
          response = @client.send(method, *args)
          wait
          result = parse(response.body)
          result
        end

        def wait
          sleep REQUEST_INTERVAL_SEC
        end
    end
  end
end
