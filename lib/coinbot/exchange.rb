require_relative './order_list'

module Coinbot

  class Exchange
    attr_reader :orders

    def initialize(client)
      @client = client
      @orders = OrderList.new
    end

    def sync
      debug 'pending orders'
      debug pending_orders_idds = @client.my_orders.orders.map(&:id)
      debug 'done orders'
      debug done_orders_idds = @client.transactions.transactions.map(&:order_id)
      debug 'orders'
      debug @orders

      @orders.each do |order|
        if pending_orders_idds.include?(order.id)
          order.state = :pending
          next
        elsif done_orders_idds.include?(order.id)
          order.state = :done
          next
        else
          order.state = :invalid
          next
        end
        :nothing
      end
    end

    def ticker
      @client.ticker
    end

    def cancel_all
      cancel(*@orders)
    end

    def cancel(*target_orders)
      target_orders.each do |order|
        result = @client.delete_orders(order.id)
        if result.success
          @orders.delete(order) if result.success
        end
      end
    end

    def buy(rate, amount)
      result = @client.buy(rate, amount)
      if result.success
        @orders << Order.new(:buy, result.id, result.rate, result.amount, :pending)
      end
    end

    def sell(rate, amount)
      result = @client.sell(rate, amount)
      if result.success
        @orders << Order.new(:sell, result.id, result.rate, result.amount, :pending)
      end
    end
  end
end
