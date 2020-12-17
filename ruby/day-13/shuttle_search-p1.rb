#! /usr/bin/env ruby

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

end

schedule = ShuttleSchedule.new(File.read('../../input/day-13/input').split("\n"))

result = schedule.earliest_bus
p result
p result[:bus] * result[:wait]

