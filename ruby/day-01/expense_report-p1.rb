#! /usr/bin/env ruby

require 'benchmark'

EX_RP = File.read('../../input/day-01/input').split("\n").map(&:to_i)

# Solution 1
def report(m) EX_RP.map {|v| v if EX_RP.include?( m - v ) }.compact end

# Solution 2, As inspired by part 2
def detect_sum_combination(q,sum) EX_RP.uniq.combination(2).to_a.detect {|a| a.inject(:+) == sum} end

# Solution 3, as inspired by https://youtu.be/2wqPuPtNiEo
def two_sum(m, tried = []) EX_RP.each {|v| diff = m - v; return [v, diff] if tried.include?(diff); tried << v } end

Benchmark.bm do |x|

  x.report("Solution 1: ") { p report(2020).inject(:*) }

  x.report("Solution 2: ") { p detect_sum_combination(2,2020).inject(:*) }

  x.report("Solution 3: ") { p two_sum(2020).inject(:*) }

end