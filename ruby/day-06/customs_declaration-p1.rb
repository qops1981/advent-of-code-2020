#! /usr/bin/env ruby

class GroupDeclarations

    def initialize(data_set)

        @data_set = data_set.split(/\s/).map {|d| d.chars }.flatten.compact

    end

    def yes_count() @data_set.uniq.length end

end

declarations = File.read('../../input/day-06/input').split(/\n\n/).map {|l| GroupDeclarations.new(l) }

p declarations.inject(0) {|sum, d| sum + d.yes_count }

