require 'ruboto/widget'
require 'ruboto/util/toast'
require_relative "logging"

def id(sym)
  find_view_by_id(R.id.send sym.to_sym)
end

$file_path = "/storage/emulated/0/code/PocketRIDE/src/pocketride_activity.rb"

class PocketrideActivity
  def on_create(bundle)
    super
    log "on_create"
    request_window_feature android.view.Window::FEATURE_NO_TITLE
    self.content_view = R.layout.main
    
    id(:button_load).set_on_click_listener do
      toast "LOAD!!!"
    end
    id(:button_save).set_on_click_listener do
      toast "SAVE!!!"
    end
  end

  def on_pause
    super
    log "on_pause"
    File.open($file_path, 'w') {|f| f.write id(:editor).text}
  end
  
  def on_resume
    super
    log "on_resume"
    id(:editor).text = File.open $file_path, &:read
  end
end

