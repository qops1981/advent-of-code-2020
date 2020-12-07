#! /usr/bin/env ruby

class GroupDeclarations

    def initialize(data_set)

        set = data_set.split(/\s/)

        @members  = set.length

        @data_set = set.map {|d| d.chars }.flatten.compact

    end

    def yes_count() @data_set.uniq.length end

    def uniq_yess()

        yess = @data_set.inject(Hash.new(0)) {|h,i| h[i] += 1; h }

        yess.count {|k,v| v == @members }

    end

end

declarations = File.read('../../input/day-06/input').split(/\n\n/).map {|l| GroupDeclarations.new(l) }

p declarations.inject(0) {|sum, d| sum + d.uniq_yess }

