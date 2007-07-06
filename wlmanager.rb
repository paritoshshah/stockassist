require 'stock'
require 'watchlist'
require 'buylist'

LOTSIZE = 10000

watchlist = Watchlist.new
watchlist.import('watchlist.txt')
watchlist.fill_quotes

buylist = Buylist.new

watchlist.each do |stockwatch|
  if stockwatch.spread <= 0.05
    buyqty = (LOTSIZE/stockwatch.tgtprice).floor
    buyitem = BuyItem.new(stockwatch.stock, stockwatch.tgtprice, buyqty)
    buylist.push buyitem
  end
end

buylist.export('buylist.txt')
watchlist.export('watchliststatus.txt')

