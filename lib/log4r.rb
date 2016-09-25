require 'log4r'
require 'log4r/outputter/datefileoutputter'
class Log4r::Logger
  def formatter
  end
end

class Log4r::CustomFileFormatter < Log4r::Formatter
  def format(event)
    if event.data.present?
      sprintf(
        "%s [%*s] %s\n",
        DateTime.now.strftime("%Y-%m-%d %H:%M:%S"),
        MaxLevelLength,
        LNAMES[event.level],
        event.data
      )
    end
  end
end
