module Parsers
  class Base
    STREET_DESIGNATIONS = %w(ave ln pl dr way cir ct rd blvd lane parkway pkwy street drive avenue place circle court boulevard road)

    def initialize(text)
      @text = text
    end

    def text
      @text ||= @file.read
    end

    def match?
      raise NotImplementedError
    end
  end
end

if __FILE__ == $0
  p ReportParser.new(__FILE__).parse
end