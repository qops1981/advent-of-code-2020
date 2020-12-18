#! /usr/bin/env ruby

class RambunctiousRecitation

    attr_reader :memory

    def initialize(data)

        @memory = data.each_with_object({}).with_index {|(d,h),i| h[d] = [i + 1] }

    end

    def turn(turn = @memory.length, last = @memory.keys.last, stop)

        while turn < stop

            value = @memory[last].length > 1 ? @memory[last].inject(:-).abs : 0

            turn += 1

            @memory.has_key?(value) ? @memory[value] = [@memory[value].last, turn] : @memory[value] = [turn]

            last = value

        end

        value

    end

end

(1..6).each do |s|

    game = RambunctiousRecitation.new(File.read('../../input/day-15/sample' + s.to_s).split("\n")[0].split(',').map(&:to_i))

    p game.turn(30000000)

end

game = RambunctiousRecitation.new(File.read('../../input/day-15/input').split("\n")[0].split(',').map(&:to_i))

p game.turn(30000000)
