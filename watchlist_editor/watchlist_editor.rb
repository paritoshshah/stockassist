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

		# define & populate the view
		watchlist_view = @glade.get_widget("watchlist")
		watchlist_view.model = watchlist_model
		WatchListModel::COLUMNS.each do |colid, colname, coltype, accessor|
			renderer = Gtk::CellRendererText.new
			column = Gtk::TreeViewColumn.new(colname, renderer)
			column.set_cell_data_func(renderer) do |column, renderer, model, iter|
				if coltype == Float
					renderer.text = sprintf("%.2f", iter[colid])
				else
					renderer.text = iter[colid]
				end
			end
			watchlist_view.append_column(column)
		end
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
	def on_dialog_open_clicked(widget)
		puts "on_dialog_open_clicked() is not implemented yet."
	end
end

