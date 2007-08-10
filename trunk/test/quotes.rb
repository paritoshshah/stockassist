require 'quotes'
require 'test/unit'

class TestQuotes < Test::Unit::TestCase

	INFO = {
		'ACC' => 'ASSOCIATED CEMENT',
		'INFOSYSTCH' => 'INFOSYS TECHNOLOG'
	}

	def test_single_quote
		symbol = 'ACC'
		quote = nil
		Quotes::get_quotes([] << symbol) do |qt|
			quote = qt
		end
		assert_equal quote.name, INFO[symbol] 
	end

	def test_multiple_quotes
		qthash = Quotes::get_quotes(INFO.keys)
		INFO.each do |symbol, name|
			assert_equal name, qthash[symbol].name
		end
	end
end
