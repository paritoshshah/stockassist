require 'watchlist'
require 'gtk2'

class WatchListModel < Gtk::ListStore

	COLUMNS = [
		[0, "Stock", String, "stock.symbol"],
		[1, "Target Price", Float, "tgtprice"],
		[2, "Last Trade", Float, "stock.quote.lastTrade"],
		[3, "Change", Float, "stock.quote.changePercent"],
		[4, "Spread", Float, "spread"]
	]

	def initialize
		params = []
		COLUMNS.each do |colid, colname, coltype, accessor|
			params << coltype
		end
		super(*params)
	end
	
	# populate the model with watchlist at filepath
	def populate(filepath)
		watchlist = Watchlist.new
		watchlist.import(filepath)
		watchlist.fill_quotes
		watchlist.each_key do |symbol|
			iter = self.append
			COLUMNS.each do |colid, colname, coltype, accessor|
				iter[colid] = eval "watchlist[symbol]."+accessor
			end
		end
	end

end
