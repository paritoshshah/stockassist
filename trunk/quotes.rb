#~ StockAssist, a portfolio management application.
#~   Homepage: <http://code.google.com/p/stockassist>
#~  
#~   Quotes class - Helper to get stock quotes.
#~     Currently just a wrapper around YahooFinance module.
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

require 'yahoofinance'

class Quotes
	def get_quotes symbols
		symlookup = Hash.new
		tickers = symbols.collect do |symbol|
			ticker = get_ticker symbol
			# save the ticker->symbol mapping
			symlookup[ticker] = symbol
			ticker
		end

		ret = Hash.new
		YahooFinance::get_quotes(YahooFinance::StandardQuote, tickers) do |qt|
			if block_given?
				yield qt
			end
			ret[symlookup[qt.symbol]] = qt
		end
	end

	#symbol: NSE symbol, ticker: Data feed symbol
	#TODO: Try BSE if NSE fails
	def get_ticker symbol
		ticker = symbol[0..8]
		if ticker =~ /\d+/
			ticker << '.BO'
		else
			ticker << '.NS'
		end
		return ticker
	end
end
