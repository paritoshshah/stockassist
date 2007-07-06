require 'stock'

#WatchList Entry
class StockWatch
  
  attr_reader :stock, :tgtprice, :change
  
  def initialize(stock, tgtprice)
    @stock = stock
    @tgtprice = tgtprice
    @change = nil
  end
  
  def <=>(other)
    self.spread <=> other.spread
  end
  
  # measure of closeness to tgtprice, useful in <=>
  def spread
    (@stock.last - @tgtprice)/@stock.last
  end
  
  def to_s
    sprintf("%15s\t%.2f\t%0.2f\t%.2f", @stock.symbol, @tgtprice, @stock.last, @change)
  end 
  
  def set_change(delta)
    @change = delta*100/(@stock.last-delta)
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
  
  def fill_quotes()
    quotes = Net::HTTP.get(URI.parse("http://in.finance.yahoo.com/d/quotes.csv?s="+self.get_tickers+"&f=l1c1&e=.csv"))
    i = 0
    quotes.each("\n") { |quote| values = /(\d*\.\d*),(.\d*\.\d*)/.match(quote.chop); self.at(i).stock.parse_quote!(values[1]); self.at(i).set_change(values[2].to_f) ; i = i +1 }
  end
  
  def get_tickers()
    tickers = ""
    self.each {|stockwatch| tickers << stockwatch.stock.get_ticker << "+"} 
    #remove trailing '+'
    tickers.chop
  end
  
end