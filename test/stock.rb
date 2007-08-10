require 'stock'
require 'test/unit'

class TestStock < Test::Unit::TestCase
	def test_stock_quote
		infosys = Stock.new('INFOSYSTCH')
		assert_equal 'INFOSYS TECHNOLOG', infosys.quote.name
	end
end
