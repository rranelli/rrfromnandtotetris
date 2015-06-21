#!/usr/bin/env ruby
require_relative 'assembler/ctable'
require_relative 'assembler/dtable'
require_relative 'assembler/jtable'
require_relative 'assembler/symbol_table'
require_relative 'assembler/instruction'
require_relative 'assembler/parser'

### Actual script
ARGV.each do |input_file|
  puts "Assembling #{input_file}..."
  output_file = input_file.gsub(/\.\w+$/, '.hack')

  program = File.read(input_file).split("\n")
  instructions = Parser.new(program).parse

  instructions
    .map(&:to_machine_code)
    .join("\n")
    .tap { |p| File.write(output_file, p + "\n") }

  puts 'Done!'
end
