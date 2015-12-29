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

    self.content_view = 
        linear_layout :orientation => :vertical do
          @text_view = text_view :text => 'What hath Matz wrought?', :id => 42, 
                                 :layout => {:width => :match_parent},
                                 :gravity => :center, :text_size => 48.0
          button :text => 'M-x butterfly', 
                 :layout => {:width => :match_parent},
                 :id => 43, :on_click_listener => proc { butterfly }
        end
  rescue Exception
    log_e $!.backtrace.join("\n")
    log_e "Exception creating activity: #{$!}"
    toast "LOGGED ERROR!"
  end

  private

  def butterfly
    @text_view.text = 'What hath Matz wrought!'
    toast 'Flipped a bit via butterfly'
  end

end
