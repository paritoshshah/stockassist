require 'libglade2'
require 'watchlist_editor/watchlist_store'

class WatchlistEditorGlade
  include GetText

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}

		# define & populate the model
		watchlist_model = WatchListModel.new
		watchlist_model.populate('watchlist_buy.txt')

		# define the view
		stock = Gtk::TreeViewColumn.new("Stock",
																		Gtk::CellRendererText.new,
																		{:text => 0})
		watchlist_view = @glade.get_widget("watchlist_view")
		watchlist_view.model = watchlist_model
		watchlist_view.append_column(stock)
		watchlist_view.selection.set_mode(Gtk::SELECTION_SINGLE)
    
  end
  
  def on_open1_activate(widget)
    puts "on_open1_activate() is not implemented yet."
  end
  def on_add_clicked(widget)
    puts "on_add_clicked() is not implemented yet."
  end
  def on_save_as1_activate(widget)
    puts "on_save_as1_activate() is not implemented yet."
  end
  def on_about1_activate(widget)
    puts "on_about1_activate() is not implemented yet."
  end
  def on_new1_activate(widget)
    puts "on_new1_activate() is not implemented yet."
  end
  def on_save1_activate(widget)
    puts "on_save1_activate() is not implemented yet."
  end
  def on_quit1_activate(widget)
    puts "on_quit1_activate() is not implemented yet."
  end
end

