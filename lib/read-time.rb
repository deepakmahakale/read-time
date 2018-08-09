module ReadTime
  def readtime(options = {})
    reading_speed = (options[:reading_speed] || ReadTime.config.reading_speed).to_f
    format = options[:format] || ReadTime.config.format
    word_count = scan(/[\w-]+/).size
    num = ((word_count / reading_speed) * 60).ceil

    minutes = num / 60
    seconds = num - (minutes * 60)

    case format
    when :default
      min = (num / 60.0).ceil
      "#{min} minute read"
    when :long
      if seconds.zero?
        "#{minutes} minute read"
      elsif minutes.zero?
        "#{seconds} second read"
      else
        "#{minutes} minute #{seconds} second read"
      end
    else
      min = (num / 60.0).ceil
      "#{min} minute read"
    end
  end

  class << self
    attr_writer :config
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.reset_config
    @config = Configuration.new
  end

  def self.configure
    yield(config)
  end

  class Configuration
    attr_accessor :format, :reading_speed

    def initialize
      @format         = :default
      @reading_speed  = 275 # WPM (words per minute)
    end
  end
end

class String
  include ReadTime
end
