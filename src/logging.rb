
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

