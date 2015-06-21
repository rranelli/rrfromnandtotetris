class Parser
  def initialize(program)
    @program = Array(program)
    @var_addr = 16
    @symbol_table = Hash.new { |hash, key| hash[key] = (self.var_addr += 1) }
  end

  def parse
    cleaned = clean(program)

    cleaned
      .reduce(cleaned) { |a, e| parse_label(e, a) }
      .map(&parse_instruction)
  end

  private

  attr_reader :program, :symbol_table
  attr_accessor :var_addr

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

  def parse_label(i, program)
    match = i.match(/^\((.*)\)$/)
    return program unless match

    symbol = match[1]
    symbol_table[symbol] = program.index(i)

    program.reject { |e| e == i }
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
