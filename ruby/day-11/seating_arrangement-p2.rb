#! /usr/bin/env ruby

class SeatArrangment

        attr_reader :seat_map

    def initialize(seat_map)

        @seat_map = seat_map

    end

    def neighbors(v,h,v_max, h_max)

        [1,1,0,-1,-1].permutation(2).to_a.uniq.map do |pos|

            v_pos = v.dup
            h_pos = h.dup

            searching = true
            occupied  = false

            state = nil

            while searching do

                v_pos += pos.first
                h_pos += pos.last

                unless v_pos.negative? || h_pos.negative? || v_pos > v_max || h_pos > h_max

                    seat = @seat_map[v_pos][h_pos]

                    searching = ( seat == '.' )

                    state = seat

                else

                    searching = false

                end

            end

            state

        end

    end

    def simulate(occupied = 0)

        projection = []

        v_max = @seat_map.length - 1

        @seat_map.each_with_index do |row, rdx|

            h_max = row.length - 1

            projection << row.map.with_index do |seat, sdx|

                adjacents = neighbors(rdx, sdx, v_max, h_max)

                seated = adjacents.count('#')

                case seat
                when 'L'

                    seated == 0 ? '#' : seat

                when '#'

                    seated > 4 ? 'L' : seat

                else

                    seat

                end

            end

        end

        sat = projection.inject(0) {|sum, row| sum += row.count('#') }

        return sat if sat == occupied

        @seat_map = projection

        simulate(sat)

    end

end

seats = SeatArrangment.new(File.read('../../input/day-11/sample').split("\n").map(&:chars))

p seats.simulate

