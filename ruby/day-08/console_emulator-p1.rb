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

    def overflow?() @position > @instructions.length - 1 end

end

class Computer

    attr_reader :accumulator

    def initialize(program)

        @program = Program.new(File.read(program))

        @accumulator = 0

        @step = nil

    end

    # Solution 1
    def process_till_second_run

        while true do

            @step = @program.step

            break if @step.runs > 0 || @program.overflow?

            send("#{@step.opr}")

            @step.runs += 1

        end

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
                position += instruction.arg

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

program = Computer.new('../../input/day-08/input')

p program.process


