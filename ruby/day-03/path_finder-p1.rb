#! /usr/bin/env ruby

class String

    def mod_idx(i) self[ i % self.length ] end

end

class SlopeMap

    def initialize(input: [])

        @map = input

    end

    def distance(step, steps) step * steps end

    def longitude(i) @map[i] end

    def position(lng, lat) longitude(lng).mod_idx(lat) end

    def tree?(lng, lat) position(lng, lat) == '#' end

    def trees_on_path(lng_stp, lat_stp, trees = 0, steps = 1)

            long = distance(lng_stp, steps)

            return trees if ( @map.length - 1 ) < long

            lati = distance(lat_stp, steps)

            trees += 1 if tree?(long, lati)

            trees_on_path(lng_stp, lat_stp, trees, steps + 1)

    end

end

slope = SlopeMap.new( input: File.read('../../input/day-03/input').split("\n") )

p slope.trees_on_path(1, 3)

