#~ StockAssist, a portfolio management application.
#~   Homepage: <http://code.google.com/p/stockassist>
#~  
#~   A collection of classes modelling a watchlist.
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
require 'quotes'

#WatchList Entry
class StockWatch
  
  attr_reader :stock, :tgtprice
  
  def initialize(stock, tgtprice)
    @stock = stock
    @tgtprice = tgtprice
  end
  
  def <=>(other)
    self.spread <=> other.spread
  end
  
  # measure of closeness to tgtprice, useful in <=>
  def spread
		cur_price = @stock.quote.lastTrade
    (cur_price - @tgtprice)/cur_price
  end
  
  def to_s
    @stock.to_s + "\t" + @tgtprice.to_s
  end 
end

# Watchlist is a map of symbol => StockWatch
class Watchlist < Hash 

  #Create a watchlist from a file
  def import(filepath)
    IO.foreach(filepath) do |nextline|
      tokens = Array.new
      nextline.each("\t") {|token| tokens.push token}
			symbol = tokens[0].chop
      stock = Stock.new(symbol)
      tgtprice = tokens[1].chop.to_f
      self[symbol] = StockWatch.new(stock, tgtprice)
    end
  end
	
  def export(filepath)
    file = File.new filepath, "w"
    self.each_key { |symbol| file.puts self[symbol].to_s+"\n" }
    file.close
  end

	def export_status(filepath)
		file = File.new filepath, "w"
		watch_stat = self.sort { |a, b| a[1] <=> b[1] }
		watch_stat.each do |symbol, stockwatch|
			stock = stockwatch.stock
			tgtprice = stockwatch.tgtprice
			file.printf "%15s\t%d\t%.1f\t%.1f\t%.2f\n", symbol, tgtprice, stock.quote.lastTrade, stock.quote.changePercent, stockwatch.spread
		end
		file.close
	end

	#get quotes for all the stocks in the watchlist
	def fill_quotes
		qthash = Quotes::get_quotes(self.keys)
		qthash.each_key { |key| self[key].stock.set_quote qthash[key] }
	end

end
