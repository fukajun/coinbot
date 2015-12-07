require_relative './loggerable'

module Coinbot
  class Trader
    include Coinbot::Loggerable
    AMOUNT = 0.001
    PROFIT = 2

    def initialize(exchange)
      @exchange = exchange
    end

    def deal
      recently_order =  @exchange.orders.recently
      buy_price = @exchange.ticker.bid.to_i
      sell_price = @exchange.ticker.ask.to_i

      if recently_order
        # すで買い注文、売り注文がある
        case recently_order.type
        when :sell
          # 売り注文
          case recently_order.state
          when :pending
            info '売り注文が保留'
            info 'キャンセル and 売値更新'
            @exchange.cancel(recently_order)
            @exchange.sell(profit_price(recently_order, sell_price), AMOUNT)
          when :done
            info '売り注文完了'
            info '次の売り注文'
            @exchange.buy(buy_price, AMOUNT)
          else
            info '何もしない'
          end

        when :buy
          # 買い注文
          case recently_order.state
          when :pending
            info '買い注文が保留'
            if recently_order.rate.to_i != buy_price
              info '指値を更新'
              @exchange.cancel(recently_order)
              @exchange.buy(buy_price, AMOUNT)
            end
          when :done
            info '買い注文完了'
            info '次の売り注文をする'
            @exchange.sell(profit_price(recently_order, sell_price), AMOUNT)
          else
            info '何もしない'
          end
        end
      else
        info '買い注文がないので 注文を買う'
        @exchange.buy(buy_price, AMOUNT)
      end

      def profit_price(buy_order, sell_price)
        price = buy_order.rate.to_i + PROFIT
        price > sell_price ? price : sell_price
      end
    end
  end
end
