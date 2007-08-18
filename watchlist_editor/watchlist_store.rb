require 'watchlist'
require 'gtk2'

class WatchListModel < Gtk::ListStore

	def initialize
		super(String)
	end
	
	# populate the model with watchlist at filepath
	def populate(filepath)
		watchlist = Watchlist.new
		watchlist.import(filepath)
		watchlist.each_key do |symbol|
			iter = self.append
			iter[0] = symbol
		end
	end

end
