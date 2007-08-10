require 'watchlist'
require 'test/unit'

class TestWatchlist < Test::Unit::TestCase

	INFO = {
		'ACC' => 'ASSOCIATED CEMENT',
		'INFOSYSTCH' => 'INFOSYS TECHNOLOG'
	}

	def setup
		@test_watchlist = Watchlist.new
		@test_watchlist.import(watchfile)
	end	

	def test_import
		INFO.each do |symbol, name|
			assert_not_nil @test_watchlist[symbol]
		end
	end

	def test_export
		@test_watchlist.export('test/export.txt')
		export_watchlist = Watchlist.new
		export_watchlist.import('test/export.txt')
		@test_watchlist.each_key do |key|
			assert_equal @test_watchlist[key].stock.symbol, export_watchlist[key].stock.symbol
			assert_equal @test_watchlist[key].tgtprice, export_watchlist[key].tgtprice
		end
	end

	def test_fill_quotes
		@test_watchlist.fill_quotes
		INFO.each do |symbol, name|
			stockwatch = @test_watchlist[symbol]
			assert_not_nil stockwatch.stock.qt
			assert_equal name, stockwatch.stock.qt.name
		end
	end

	def watchfile
		'test/test_watchlist.txt'
	end
end
