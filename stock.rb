#~ StockAssist, a portfolio management application.
#~   Homepage: <http://code.google.com/p/stockassist>
#~  
#~   A collection of classes modelling a stock.
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

class Stock
  attr_reader :symbol, :last, :change, :daylow
  attr_writer :last, :change, :daylow
  
  def initialize(symbol, last=nil, change=nil, daylow=nil)
    @symbol = symbol
    @last = last
    @change = change
    @daylow = daylow
  end

  def to_s
    @symbol + "\t" + @last.to_s + "\t" + @change.to_s + "\t" + @daylow.to_s
  end
end