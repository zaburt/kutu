# require 'logger'

# class ActiveSupport::BufferedLogger
#   def formatter=(formatter)
#     @log.formatter = formatter
#   end
# end

class ActiveSupport::Logger::SimpleFormatter
  SEVERITY_TO_COLOR_MAP = {
    'DEBUG' => '0;37',
    'INFO' => '32',
    'WARN' => '33',
    'ERROR' => '31',
    'FATAL' => '31',
    'UNKNOWN' => '37'
  }.freeze

  def call(severity, time, _progname, msg)
    use_color = false

    if use_color
      formatted_severity = format('%-5s', severity.to_s)
      # formatted_time = time.strftime('%Y-%m-%d %H:%M:%S.') << time.usec.to_s[0..2].rjust(3)
      formatted_time = time.strftime('%Y-%m-%d %H:%M:%S.%L %z')
      color = SEVERITY_TO_COLOR_MAP[severity]

      "\033[0;37m#{formatted_time}\033[0m [\033[#{color}m#{formatted_severity}\033[0m] #{msg.strip} (pid:#{$PID})\n"
    else
      pattern = Regexp.new("^#{Rails.root rescue Dir.pwd}")
      location = (Kernel.caller.detect{|c| c.match(pattern)} || '').split('/')[-1]

      format(
        "[%s] (%d) %5s %s %s\n",
        time.strftime('%Y-%m-%d %H:%M:%S.%L %z'),
        $PID,
        severity,
        location,
        msg2str(msg)
      )
    end
  end
end

