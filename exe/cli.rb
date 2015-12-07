require 'thor'
require 'ruby_coincheck_client'
require_relative '../lib/coinbot/bot'

class CLI < Thor

  desc '', ''
  option :price, type: :numeric, default: nil
  option :profitloss, type: :numeric, default: 0
  def start
    bot = Coinbot::Bot.new
    puts 'Ctrl + C でストップ(注文は全キャンセル)'
    Signal.trap(:INT){
      bot.stop
    }
    bot.run
  end
end
CLI.start(ARGV)
