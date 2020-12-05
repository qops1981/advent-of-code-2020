#! /usr/bin/env ruby

EX_RP = File.read('../../input/day-01/input').split("\n").map(&:to_i)

def detect_sum_combination(q,sum) EX_RP.uniq.combination(q).to_a.detect {|a| a.inject(:+) == sum } end

p detect_sum_combination(3,2020).inject(:*)