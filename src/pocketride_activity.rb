require 'ruboto/widget'
require 'ruboto/util/toast'

def log_e(msg)
  android.util.Log.e "PocketRIDE", msg.to_s
end

def log_w(msg)
  android.util.Log.v "PocketRIDE", caller[0].to_s
  android.util.Log.w "PocketRIDE", msg.to_s
end

def log(msg)
  android.util.Log.v "PocketRIDE", caller[0].to_s
  android.util.Log.i "PocketRIDE", msg.to_s
end

begin
  require "java"
  class SystemOutLogging < java.io.PrintStream
    def println(line)
      log_w line
    end
  end
  class SystemErrLogging < java.io.PrintStream
    def println(line)
      log_e line
      log_e $!.backtrace.join("\n")
      log_e $!
    end
  end
  java.lang.System.set_out SystemOutLogging.new java.lang.System.out
  java.lang.System.set_err SystemErrLogging.new java.lang.System.err
  java.lang.System.out.println "now logging System.out&err"
rescue Exception
  log_e $!.backtrace.join("\n")
  log_e "Exception creating System.out&err logging: #{$!}"
end

class PocketrideActivity
  def on_create(bundle)
    super
    log "on_create"
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
