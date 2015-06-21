class Parser
  def initialize(program)
    @program = Array(program)
    @symbol_table = SymbolTable.new
  end

  def parse
    cleaned = clean(program)

    cleaned.reduce(0) { |a, e| parse_label(e, a) }
    cleaned
      .reject { |i| i.match(/^\((.*)\)$/) }
      .map(&parse_instruction)
  end

  private

  attr_reader :program, :symbol_table

  def parse_instruction
    -> (i) { parse_a(i) || parse_c(i) || fail(ArgumentError, i) }
  end

  def parse_a(i)
    match = i.match(/^@(.*)$/)
    return unless match

    Instruction::A.new(match[1], symbol_table)
  end

  def parse_c(i)
    match = i.match(/^(?:(\w+)=)?([10+\-!DAM&|]+)(?:;(\w{3}))?$/)
    return unless match

    Instruction::C.new(*match.captures)
  end

  def parse_label(i, iindex)
    match = i.match(/^\((.*)\)$/)
    return iindex + 1 unless match

    symbol = match[1]
    symbol_table[symbol] = iindex
  end

  def clean(program)
    program
      .map(&strip_whitespace)
      .compact
      .reject(&:empty?)
  end

  def strip_whitespace
    -> (line) { line.gsub(%r{(//.*$|\s)}, '') }
  end
end
