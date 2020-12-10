#! /usr/bin/env ruby

class XmasCipher

    attr_reader :preamble, :code

    def initialize(code, preamble_length)

        @preamble_range = preamble_length

        @code = code

    end

    def cipher_value_matches(value, index)

        p_start = index - @preamble_range
        p_end   = index - 1

        sum_seek(@code[p_start..p_end], value)

    end

    def sum_seek(preamble, sum, tried = [])

        preamble.map do |v|

            diff = sum - v
            found = tried.include?(diff) ? [v, diff] : nil
            tried << v
            found

        end.compact

    end

    def invalid_cipher_value

        p_start = @preamble_range - 1

        @code.detect.with_index {|c, idx| cipher_value_matches(c, idx).empty? && ! idx.between?(0, p_start) }

    end

    # def process

    #     p_start = @preamble_range - 1

    #     @code.each_with_index do |c, idx|

    #         # printf("Code: %d, Index: %d => ", c, idx) unless idx.between?(0, p_start)
    #         # p cipher_value_matches(c, idx) unless idx.between?(0, p_start)

    #         unless idx.between?(0, p_start)

    #             matches = cipher_value_matches(c, idx)

    #             return { code: c, status: 'error', message: 'cipher error, no preamble sum'} if matches.empty?

    #         end

    #     end

    # end


end

def two_sum(m, tried = []) EX_RP.each {|v| diff = m - v; return [v, diff] if tried.include?(diff); tried << v } end

cipher = XmasCipher.new(File.read('../../input/day-09/input').split("\n").map(&:to_i), 25)

# p cipher.process

p cipher.invalid_cipher_value
