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

# read the watchlist
watchlist = Watchlist.new
watchlist.import('watchlist.txt')
watchlist.fill_quotes

# build a buylist from the watchlist
buylist = Buylist.new
watchlist.each_key do |symbol|
	stockwatch = watchlist[symbol]
  if stockwatch.spread <= 0.05
    buyitem = BuyItem.new(stockwatch.stock, stockwatch.tgtprice)
    buylist[symbol] = buyitem
  end
end

# export buylist and watchliststatus
buylist.export('buylist.txt')
watchlist.export_status('watchliststatus.txt')
