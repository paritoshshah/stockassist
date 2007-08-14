#~ StockAssist, a portfolio management application.
#~   Homepage: <http://code.google.com/p/stockassist>
#~  
#~   stockassist - a makeshift controller, till we have a UI
#~    
#~ Copyright (C) 2007 Paritosh Shah <shah DOT paritosh AT gmail DOT com>
#~
#~ This program is free software: you can redistribute it and/or modify
#~ it under the terms of the GNU General Public License as published by
#~ the Free Software Foundation, either version 3 of the License, or
#~ (at your option) any later version.
#~
#~ This program is distributed in the hope that it will be useful,
#~ but WITHOUT ANY WARRANTY; without even the implied warranty of
#~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#~ GNU General Public License for more details.
#~
#~ You should have received a copy of the GNU General Public License
#~ along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'stock'
require 'watchlist'
require 'buylist'

# read the watchlists
watchlist_buy = Watchlist.new
watchlist_buy.import('watchlist_buy.txt')
watchlist_buy.fill_quotes
watchlist_sell = Watchlist.new
watchlist_sell.import('watchlist_sell.txt')
watchlist_sell.fill_quotes

# build a buylist from watchlist_buy
buylist = Buylist.new
watchlist_buy.each_key do |symbol|
	stockwatch = watchlist_buy[symbol]
  if stockwatch.spread <= 0.05
    buyitem = BuyItem.new(stockwatch.stock, stockwatch.tgtprice)
    buylist[symbol] = buyitem
  end
end

# build a selllist from watchlist_sell
selllist = watchlist_sell.reject { |symbol, stockwatch| stockwatch.spread < -0.05 }

# export buylist and watchliststatus
buylist.export('buylist.txt')
watchlist_buy.export_status('buystatus.txt')
watchlist_sell.export_status('sellstatus.txt')
selllist.export('selllist.txt')
