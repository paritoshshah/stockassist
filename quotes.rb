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
