#~ StockAssist, a portfolio management application.
#~   Homepage: <http://code.google.com/p/stockassist>
#~  
#~   Quotes module - Helper to get stock quotes.
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

require 'net/http'
require 'uri'
require 'csv'

module Quotes
    def fill_quotes stocks
        quotecsv = Net::HTTP.get(URI.parse("http://in.finance.yahoo.com/d/quotes.csv?s="+accum_tickers+"&f=sl1c1g&e=.csv"))
        quotes = CSV.parse quotecsv
        quotes.each_index do |i|
            # sanity check
            if quotes[i][0] =~ /stocks[i].symbol/
                stocks[i].last = quotes[i][1].to_f
                stocks[i].change = quotes[i][2].to_f
                stocks[i].daylow = quotes[i][3].to_f
            end
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

    # accumulate multiple symbols into TICK1+TICK2+...
    def accum_tickers stocks
        stocks.collect {|stock| get_ticker stock.symbol}.join('+')
    end
end
