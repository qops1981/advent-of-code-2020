#! /usr/bin/env ruby

class JoltageAdapters

    attr_reader :diffs

    def initialize(adapters)

        @adapters = adapters

        @diffs    = {}

        @device = @adapters.max + 3

    end

    def catalog_diff(d) @diffs.has_key?(d) ? @diffs[d] += 1 : @diffs[d] = 1 end

    def sorted_adapters() @sorted_adapters ||= @adapters.sort end

    def assemble(index = 0, past = 0)

        if index > @adapters.length - 1

            catalog_diff(@device - past)

        else

            adapter = sorted_adapters[index]

            catalog_diff(adapter - past)

            assemble(index += 1, past = adapter)

        end

    end

end

adapters = JoltageAdapters.new(File.read('../../input/day-10/input').split("\n").map(&:to_i))

adapters.assemble
p adapters.diffs
p adapters.diffs.values.inject(:*)
