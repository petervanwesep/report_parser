module Parsers
  class MetrolistLong
    def self.match?(text)
      text[/One Line Report with DOM/].present?
    end

    def parse
      lines = text.split("\n")
      lines.each do |line|

      end
    end
  end
end