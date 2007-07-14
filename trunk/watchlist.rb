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
    (@stock.last - @tgtprice)/@stock.last
  end
  
  def to_s
    @stock.to_s + "\t" + @tgtprice.to_s
  end 
end

# Watchlist is a list of StockWatch
class Watchlist < Array
  #Create a watchlist from a file
  def import(filepath)
    IO.foreach(filepath) do |nextline|
      tokens = Array.new
      nextline.each("\t") {|token| tokens.push token}
      stock = Stock.new(tokens[0].chop)
      tgtprice = tokens[1].chop.to_f
      self.push StockWatch.new(stock, tgtprice)
    end
  end
  
  def export(filepath)
    file = File.new filepath, "w"
    self.each { |stockwatch| file.puts stockwatch.to_s+"\n" }
    file.close
  end
end
