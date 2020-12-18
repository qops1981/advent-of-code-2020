#! /usr/bin/env ruby

class DockingComputer

    attr_reader :mem

    def initialize(data)

        @mem = {}

        data.each do |c|

            line = c.split(' ')

            if line[0] == 'mask'

                instance_variable_set("@#{line[0]}", line[2])

            else

                line[2] = mask_bits(line[2].to_i)

                eval('@' + line.join(' '))

            end

        end

    end

    def mask_bits(code)

        code = code.to_s(2).rjust(36, '0')

        @mask.chars.each_with_index {|m,i| code[i] = m unless m == 'X' }

        code.to_i(2)

    end

    def sum() @mem.values.inject(:+) end

end

computer = DockingComputer.new(File.read('../../input/day-14/input').split("\n"))

p computer.sum
