module Coinbot
  class Brain
    #CHARGE = 0.0
    #GAIN = 10.0
    #LOSSCUT = 1000.0
    #AMOUNT = 0.001

    #def initialize(prev_price = nil, profitloss = 0)
      #@price = prev_price
      #@profit_loss = profitloss
    #end

    #def buy(ask)
      #puts "## buy: #{ask}"
      #@order = Coinbot::Order.buy(ask, AMOUNT)
    #end

    #def sell(bid)
      #puts "## sell: #{bid}"
      #@order = Coinbot::Order.sell(bid, AMOUNT)
    #end

    #def deal(bid, ask)
      #puts "bid: #{bid}, ask: #{ask}"
      #unless @order
        #p buy(ask)
      #else
        #puts @order.state
        #do_sell = false
        #if profit_taking?(bid)
          #print 'profit '
          #do_sell = true
        #elsif stop_loss?(bid)
          #print 'losscut '
          ##do_sell = true
        #end
        #sell(bid) if do_sell
      #end
    #end

    #private
      #def profit_taking?(bid)
        #return false unless @price
        #bid >= wanted_price
      #end

      #def stop_loss?(bid)
        #return false unless @price
        #bid <= losscut_price
      #end

      #def wanted_price
        #@price + CHARGE + GAIN
      #end

      #def losscut_price
        #@price - LOSSCUT
      #end
  end
end
