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

  