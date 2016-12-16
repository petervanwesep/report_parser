module Parsers
  class MetrolistLong
    def parse
      lines = text.split("\n")
      lines.each do |line|

      end
    end

    def self.match?(text)
      text[/One Line Report with DOM/].present?
    end
  end
end