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
