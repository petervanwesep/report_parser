module Parsers
  def self.parse(filename)
    text = File.open(filename).read
    [MetrolistShort, MetrolistLong].each do |parser_class|
      return parser_class.new(text).parse if parser_class.match?(text)
    end
  end
end