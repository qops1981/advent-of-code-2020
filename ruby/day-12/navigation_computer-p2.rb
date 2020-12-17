#! /usr/bin/env ruby

class Position

    attr_accessor :ns, :ew

    def initialize(ew = 0, ns = 0)

        @ew = ew
        @ns = ns

    end

    def rotate_x(deg, x, y) r = deg*Math::PI/180; x * Math.cos(r) + y * Math.sin(r) end

    def rotate_y(deg, x, y) r = deg*Math::PI/180; y * Math.cos(r) - x * Math.sin(r) end

    def rotate(deg)

        ew, ns = @ew, @ns

        @ew, @ns = rotate_x(deg, ew, ns).round, rotate_y(deg, ew, ns).round

    end

end

class NavigationComputer

    def initialize(data)

        @ship     = Position.new
        @waypoint = Position.new(10,1)

        data.each {|d| compute(*d) }

    end

    def compute(i,v)

        case i
        when 'N'; @waypoint.ns += v
        when 'S'; @waypoint.ns += -v
        when 'E'; @waypoint.ew += v
        when 'W'; @waypoint.ew += -v
        when 'L'; @waypoint.rotate(-v)
        when 'R'; @waypoint.rotate( v)
        when 'F'; @ship.ew += @waypoint.ew * v; @ship.ns += @waypoint.ns * v
        end

    end

    def manhattan_distance() @ship.ew.abs + @ship.ns.abs end

end

computer = NavigationComputer.new(File.read('../../input/day-12/input').split("\n").map {|v| [v[0], v[1..-1].to_i] })

p computer.manhattan_distance

