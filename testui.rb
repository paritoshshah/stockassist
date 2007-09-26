require 'watchlist_editor/watchlist_editor'

# Main program
if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "watchlist_editor/watchlist_editor.glade"
  PROG_NAME = "WatchListEditor"
  WatchlistEditorGlade.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end
