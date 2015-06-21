var_addr = 15
SYMBOL_TABLE = Hash.new { |hash, key| hash[key] = (var_addr += 1) }
SYMBOL_TABLE.tap do |h|
  h['SP']     = 0
  h['LCL']    = 1
  h['ARG']    = 2
  h['THIS']   = 3
  h['THAT']   = 4
  h['R0']     = 0
  h['R1']     = 1
  h['R2']     = 2
  h['R3']     = 3
  h['R4']     = 4
  h['R5']     = 5
  h['R6']     = 6
  h['R7']     = 7
  h['R8']     = 8
  h['R9']     = 9
  h['R10']    = 10
  h['R11']    = 11
  h['R12']    = 12
  h['R13']    = 13
  h['R14']    = 14
  h['R15']    = 15
  h['SCREEN'] = 16_384
  h['KBD']    = 24_576
end
