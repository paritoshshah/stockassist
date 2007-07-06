require 'net/http'
require 'uri'

class Stock
  
  attr_reader :symbol, :last
  
  def initialize(symbol)
    @symbol = symbol
  end
  
  #TODO: maintain timestamps & log quotes
  def get_quote(symbol)
    Net::HTTP.get(URI.parse("http://in.finance.yahoo.com/d/quotes.csv?s="+self.get_ticker+"&f=l1&e=.csv"))
  end
  
  def parse_quote!(quote)
    @last = quote.to_f
    if @last == 0.0
      @symbol << 'INVALID'
    end
  end
  
  #symbol: NSE symbol, ticker: Data feed symbol
  #TODO: Try BSE if NSE fails
  def get_ticker
    ticker = @symbol[0..8]
    if ticker =~ /\d+/
      ticker << '.BO'
    else
      ticker << '.NS'
    end
    return ticker
  end
  
end