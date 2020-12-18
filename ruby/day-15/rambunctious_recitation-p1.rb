#! /usr/bin/env ruby

class RambunctiousRecitation

    attr_reader :memory

    def initialize(data)

        @memory = data

    end

    def turn(turn = @memory.length, stop)

        hindsight = @memory.reverse

        repeated  = hindsight[1..-1].index(hindsight[0])

        @memory << (repeated.nil? ? 0 : repeated + 1)

        return @memory.last if (turn + 1) == stop

        turn(turn.next, stop)

    end

end

# (1..6).each do |s|
#
#     game = RambunctiousRecitation.new(File.read('../../input/day-15/sample' + s.to_s).split("\n")[0].split(',').map(&:to_i))
#
#     p game.turn(2020)
#
# end

game = RambunctiousRecitation.new(File.read('../../input/day-15/input').split("\n")[0].split(',').map(&:to_i))

p game.turn(2020)
