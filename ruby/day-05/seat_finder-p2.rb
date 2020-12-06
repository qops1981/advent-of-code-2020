#! /usr/bin/env ruby

class BoardingPass

    def initialize(partition_code, rows, columns)

        @row_code,    @rows    = partition_code[0..6].chars.map{|c| c == 'F' }, [0, rows]

        @column_code, @columns = partition_code[7..9].chars.map{|c| c == 'L' }, [0, columns]

    end

    def pos_seek(code, positions)

        return positions.first if code.empty?

        midd = ( positions.inject(:-).abs / 2.0 )

        if code.shift

            positions[1] = positions[0] + midd.floor

        else

            positions[0] = positions[0] + midd.ceil

        end

        pos_seek(code, positions)

    end

    def seat_id() pos_seek(@row_code, @rows) * 8 + pos_seek(@column_code, @columns) end

end

boarding_passes = File.read('../../input/day-05/input').split("\n").map {|l| BoardingPass.new(l, 127, 7) }

seats = boarding_passes.map {|pass| pass.seat_id }

p ((seats.min..seats.max).to_a - seats)[0]

