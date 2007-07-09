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
