module Coinbot
  Order = Struct.new('Order', :type, :id, :rate, :amount, :state)

  class OrderList
    include Enumerable

    def initialize
      @list = []
    end

    def add(order)
      @list << order unless @list.any? {|o| o.id == order.id }
    end
    alias :<< :add

    def delete(order)
      @list = @list.delete_if {|o| o.id == order.id }
    end

    def recently
      @list.last
    end

    def sells
      filter(:sell)
    end

    def buys
      filter(:buy)
    end

    def each(&block)
      @list.each(&block)
    end

    def inspect
      @list.inspect
    end

    private
      def filter(type)
        @list.select {|o| o.type == type }
      end
  end
end
