#! /usr/bin/env ruby


class InstructionObject

    attr_accessor :runs

    def initialize(instruction)

       @operation, @argurment = instruction.split(/\s/)

       @runs = 0

    end

    def operation() @operation end

    alias_method :opr, :operation

    def argurment() @argurment.to_i end

    alias_method :arg, :argurment

end

class Program

    attr_accessor :position, :instructions

    def initialize(code)

        @instructions = code.split("\n").map {|t| InstructionObject.new(t) }

        @position = 0

    end

    def step() @instructions[@position] end

    def jmps() @instructions.count {|i| i.opr == 'jmp' } end

    def jmp_pos() pos = []; @instructions.each_with_index {|i,idx| pos << idx if i.opr == 'jmp' }; pos end

end

class Computer

    attr_reader :accumulator

    def initialize(program, nop_pos)

        @program = program

        @nop_pos = nop_pos

    end

    # Solution 2, slept on it.
    def process(position = 0, accumulator = 0)

        case

        when position == ( @program.instructions.length )

            return { accumulator: accumulator, status: 'complete' }

        when @program.instructions[position].runs > 0

            return { accumulator: accumulator, status: 'error', message: 'Infinate Loop' }

        else

            instruction = @program.instructions[position]
            # printf("Position: %d, Instruction: %s\n", position, instruction.opr)
            case instruction.opr

            when 'jmp'
                # p position
                position += ( position == @nop_pos ? 1 : instruction.arg )

            when 'acc'
                # p instruction.arg
                accumulator += instruction.arg
                position += 1

            when 'nop'

                position += 1

            end

            instruction.runs += 1

            process(position, accumulator)

        end

    end

end

program = Program.new(File.read('../../input/day-08/input'))

program.jmp_pos.each do |j| 

    results =  Computer.new(Program.new(File.read('../../input/day-08/input')), j).process

    p results[:accumulator] if results[:status] == 'complete'

end






