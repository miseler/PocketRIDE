require 'ruboto/widget'
require 'ruboto/util/toast'

ruboto_import_widgets :Button, :LinearLayout, :TextView

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
  rescue Exception
    log_e $!.backtrace.join("\n")
    log_e "Exception creating activity: #{$!}"
    toast "LOGGED ERROR!"
  end

  private

end
