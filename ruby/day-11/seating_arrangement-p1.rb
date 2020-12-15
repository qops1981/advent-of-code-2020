#! /usr/bin/env ruby

class SeatArrangment

        attr_reader :seat_map

    def initialize(seat_map)

        @seat_map = seat_map

    end

    def neighbors(v,h,v_max, h_max)

        [1,1,0,-1,-1].permutation(2).to_a.uniq.map do |pos|

            v_pos = v + pos.first
            h_pos = h + pos.last

            @seat_map[v_pos][h_pos] unless v_pos.negative? || h_pos.negative? || v_pos > v_max || h_pos > h_max

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

                # printf("Seated: %d, ", seated); p adjacents

                case seat
                when 'L'

                    seated == 0 ? '#' : seat

                when '#'

                    seated > 3 ? 'L' : seat

                else

                    seat

                end

            end

        end

        # projection.each do |row|

        #    row.each do |seat|

        #        printf("%s", seat)

        #    end

        #    puts

        # end

        # puts '-----------'

        sat = projection.inject(0) {|sum, row| sum += row.count('#') }

        return sat if sat == occupied

        @seat_map = projection

        simulate(sat)

    end

end

seats = SeatArrangment.new(File.read('../../input/day-11/input').split("\n").map(&:chars))

# seats.seat_map.each do |row|

#     row.each do |seat|

#         printf("%s", seat)

#     end

#     puts

# end

# puts "----------"

p seats.simulate

