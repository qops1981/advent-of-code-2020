#! /usr/bin/env ruby

class JoltageAdapters

    attr_reader :diffs, :arrangments, :device, :adapters

    def initialize(adapters)

        @adapters = adapters

        @diffs    = {}

        @device = @adapters.max + 3

        @arrangments = 0

        @steps = 0

    end

    def catalog_diff(d) @diffs.has_key?(d) ? @diffs[d] += 1 : @diffs[d] = 1 end

    def sorted_adapters() @sorted_adapters ||= @adapters.sort end

    alias_method :sa, :sorted_adapters

    def assemble(index = 0, past = 0)

        if index > @adapters.length - 1

            catalog_diff(@device - past)

        else

            adapter = sorted_adapters[index]

            catalog_diff(adapter - past)

            assemble(index += 1, past = adapter)

        end

    end

    # Horrible solution, not optimized, long run 3^n, badness
    def arrange(last = 0, adapters = @adapters.sort)

        # printf("\r%d, %d", current_max_jolt, @arrangments)

        current_max_jolt = last + 3

        unless ( current_max_jolt ) > @device

            if ( current_max_jolt ) == @device

                @arrangments += 1

            else

                min = last
                max = min + 3

                matching = adapters.select {|a| a.between?(min,max)}

                matching.each do |m|

                    arrange(m, adapters.reject {|a| a == m})

                end

            end

        end

    end

    # Not proud of it. I had to look it up.
    # assumes diffs between values are less than 3 as proven in part 1
    def solution2

        memory = {0 => 1}

        @adapters.sort.each do |a|
            memory[a] = 0
            memory[a] += memory[a - 1] if memory.has_key?(a - 1)
            memory[a] += memory[a - 2] if memory.has_key?(a - 2)
            memory[a] += memory[a - 3] if memory.has_key?(a - 3)
        end

        memory[@adapters.max]

    end

    # Solution Inspired by https://youtu.be/_f8N7qo_5hA
    def solution3(idx = 0, memo = {})

        return memo[idx] if memo.has_key?(idx)

        return 1 if idx == sa.length - 1

        total = 0

        (1..3).each do |i|

            look_ahead = idx + i

            if ! ( look_ahead > sa.length - 1 ) && sa[look_ahead] - sa[idx] <= 3

                total += solution3(look_ahead, memo)

            end

        end

        memo[idx] = total

        return total

    end

end

adapters = JoltageAdapters.new(File.read('../../input/day-10/sample1').split("\n").map(&:to_i))

require 'benchmark'

Benchmark.bm do |x|

  x.report("Solution 2: ") { p adapters.solution2 }

  x.report("Solution 3: ") { p adapters.solution3 }

end





# p adapters.adapters.sort
# p adapters.adapters.max + 3
# puts
#adapters.arrange
# p adapters.arrangments

