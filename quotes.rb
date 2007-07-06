module Quotes
    def format
        formatstr = 'l1c1g'
    end

    def get_quote stocks, *params
        
    end
    
    def parse_quote quote, *params
    
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
