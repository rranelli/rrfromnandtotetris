class Instruction
  class A
    def initialize(value, symbol_table)
      @value, @symbol_table = value, symbol_table
    end

    attr_reader :value, :symbol_table

    def to_machine_code
      '0%015b' % address
    end

    private

    def address
      literal_address || symbol_table[value]
    end

    def literal_address
      Integer(value) rescue nil
    end
  end

  class C
    def initialize(dest, cmp, jmp)
      @dest, @cmp, @jmp = dest, cmp, jmp
    end

    attr_reader :dest, :cmp, :jmp

    def to_machine_code
      '111%{cmp}%{dest}%{jmp}' % {
        cmp: CTABLE.fetch(cmp),
        dest: DTABLE.fetch(dest),
        jmp: JTABLE.fetch(jmp)
      }
    end
  end
end
