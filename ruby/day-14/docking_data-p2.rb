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

                @memory_adresses = []

                setter = line[0].match(/(mem\[)(\d+)(\])/).captures

                cipher = mask_bits(setter[1].to_i)

                memory_address_decoder(cipher)

                @memory_adresses.each do |a|

                    setter[1] = a.to_s

                    line[0]   = setter.join

                    eval('@' + line.join(' '))

                end

            end

        end

    end

    def memory_address_decoder(cipher)

        if cipher.include?('X')

            floting_bit = cipher.index('X')

            ['0','1'].each do |b|

                c = cipher.dup; c[floting_bit] = b

                memory_address_decoder(c)

            end

        else

            @memory_adresses << cipher.to_i(2)

        end

    end


    def mask_bits(code)

        code = code.to_s(2).rjust(36, '0')

        @mask.chars.each_with_index {|m,i| code[i] = m unless m == '0' }

        code

    end

    def sum() @mem.values.inject(:+) end

end

computer = DockingComputer.new(File.read('../../input/day-14/input').split("\n"))

p computer.sum
