#! /usr/bin/env ruby

class XmasCipher

    attr_reader :preamble, :code

    def initialize(code, preamble_length)

        @preamble_range = preamble_length

        @code = code

    end

    def preamble(index)

        @code[(index - @preamble_range)..(index - 1)]

    end

    def valid_cipher_code?(sum, idx, tried = [])

        preamble(idx).any? {|v| diff = sum - v; trg = tried.include?(diff); tried << v; trg}

    end

    def invalid_cipher_value

        p_start = @preamble_range - 1

        @code.detect.with_index {|c, idx| ! valid_cipher_code?(c, idx) && ! idx.between?(0, p_start) }

    end

    def seek_sum_match(sum)

        last_idx = @code.length - 1

        (2..( last_idx )).each do |r|

            last_shifted_idx = r - 1

            (0..( last_idx - last_shifted_idx )).each do |idx_start|

                idx_end = idx_start + last_shifted_idx

                range = @code[idx_start..idx_end]

                return range.min + range.max if @code[idx_start..idx_end].inject(:+) == sum

            end

        end

    end

    def weakness_value() seek_sum_match(invalid_cipher_value) end

end

cipher = XmasCipher.new(File.read('../../input/day-09/input').split("\n").map(&:to_i), 25)

p cipher.weakness_value
