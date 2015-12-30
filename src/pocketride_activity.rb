require 'ruboto/widget'
require 'ruboto/util/toast'

def log_e(msg)
  android.util.Log.e "PocketRIDE", msg.to_s
end

def log(msg)
  android.util.Log.d "PocketRIDE", caller[0].to_s
  android.util.Log.i "PocketRIDE", msg.to_s
end

class PocketrideActivity
  def onCreate(bundle)
    super
    request_window_feature android.view.Window::FEATURE_NO_TITLE
    self.content_view = R.layout.main
    
    find_view_by_id(R.id.button_load).set_on_click_listener do
      toast "LOAD!!!"
    end
    find_view_by_id(R.id.button_save).set_on_click_listener do
      toast "SAVE!!!"
    end
    
  rescue Exception
    log_e $!.backtrace.join("\n")
    log_e "Exception creating activity: #{$!}"
    toast "LOGGED ERROR!"
  end
end
