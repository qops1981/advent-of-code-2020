#! /usr/bin/env ruby

RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

class ShuttleSchedule

    def initialize(data)

        @arrival = data[0].to_i

        @busses = data[1].split(',')

    end

    def live_busses() @live_busses ||= @busses.reject {|r| r == 'x'}.map(&:to_i) end

    def earliest_bus(time = @arrival, steps = 0)

        bus = live_busses.detect {|b| time % b == 0 }

        return { arrival: @arrival, wait: time - @arrival, bus: bus } unless bus.nil?

        earliest_bus(time += 1, steps += 1)

    end

    def all_but_first_route()

        @all_but_first_route ||= @busses.partition { |x| x == live_busses[0].to_s }[1]

    end

    def cascade?(time, found = false)

        all_but_first_route.each_with_index do |b, idx|

            unless b == 'x'

                break if ( time + idx + 1 ) % b.to_i != 0

                found = true if idx == all_but_first_route.length - 1

            end

        end

        found

    end

    def cascade_departures(not_found = true)

        time = 0

        while not_found do

            not_found = ! cascade?(time)

            time += live_busses[0] if not_found

        end

        time

    end

    # Inspired from subreddit
    def cascade2(time = 0, step = 1)

        @busses.each_with_index do |b,idx|

            unless b == 'x'

                time += step until (time + idx) % b.to_i == 0

                step *= b.to_i

            end

        end

        time

    end

end

# (2..6).each do |s|
#
#     schedule = ShuttleSchedule.new(File.read('../../input/day-13/sample' + s.to_s).split("\n"))
#
#     p schedule.cascade2
#
# end


schedule = ShuttleSchedule.new(File.read('../../input/day-13/input').split("\n"))
p schedule.cascade2