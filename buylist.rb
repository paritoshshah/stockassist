#~ StockAssist, a portfolio management application.
#~   Homepage: <http://code.google.com/p/stockassist>
#~  
#~   A collection of classes modelling a buylist.
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
class BuyItem
  
  attr_reader :stock, :buyprice, :buyqty
  
  def initialize(stock, buyprice, buyqty)
    @stock = stock
    @buyprice = buyprice
    @buyqty = buyqty
  end
  
  def <=>(other)
    self.spread <=> other.spread
  end
  
  # measure of closeness to buyprice, useful in <=>
  def spread
    (@stock.last - @buyprice)/@stock.last
  end
  
  def to_s
    @stock.symbol+"\t"+@buyprice.to_s+"\t"+@buyqty.to_s
  end 
  
end

# Buylist is a list of BuyItem(s)
class Buylist < Array
  
  #spit buylist to file
  def export(filepath)
    file = File.new filepath, "w"
    self.each { |buyitem| file.puts buyitem.to_s+"\n" }
    file.close
  end
  
end