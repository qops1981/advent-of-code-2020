#! /usr/bin/env ruby

class NavigationComputer

    def initialize(data)

        @facing = ['E','S','W','N']

        @north_south = 0
        @east_west   = 0

        data.each {|d| compute(*d) }

    end

    def compute(i,v)

        case i
        when 'N'; @north_south += v
        when 'S'; @north_south += -v
        when 'E'; @east_west   += v
        when 'W'; @east_west   += -v
        when 'L'; @facing = @facing.rotate(-(v/90))
        when 'R'; @facing = @facing.rotate( (v/90))
        when 'F'; compute(@facing[0],v)
        end


    end

    def manhattan_distance() @east_west.abs + @north_south.abs end

end

computer = NavigationComputer.new(File.read('../../input/day-12/input').split("\n").map {|v| [v[0], v[1..-1].to_i] })

p computer.manhattan_distance

