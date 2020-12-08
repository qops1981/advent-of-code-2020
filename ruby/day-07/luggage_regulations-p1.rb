#! /usr/bin/env ruby

class String

    def numeric?() Float(self) != nil rescue false end

end

class Regulation

    attr_reader :key, :values

    def initialize(data_string)

        deconstruction = base_map(data_string).map {|t| remove_bag_text(t) }

        @key = value_parse(deconstruction[0])

        @values = Hash[deconstruction[1].split(', ').map {|v| v == 'no other'? ['none',0] : values_map(v) }]

    end

    def base_map(b) b.match(/(.*) bags contain (.*)/).captures end

    def values_map(v) v.match(/(\d+)? (.*)/).captures.map {|m| value_parse(m) }.reverse end

    def value_parse(v) v.numeric? ? v.to_i : v.gsub(' ', '_') end

    def remove_bag_text(s) s.gsub(/ bag(s)?(\.)?/, '') end

    def to_a() [@key, @values] end

end


class LuggageRegulations

    attr_reader :regulations

    def initialize(data_set)

        @regulations = Hash[data_set.split("\n").map {|r| Regulation.new(r).to_a }]

    end

    def bag_trace(bag_color, key)

        if @regulations[key].has_key?('none')

            return false

        elsif @regulations[key].has_key?(bag_color)

            return true

        else

            @regulations[key].any? {|k,_| bag_trace(bag_color, k) }

        end

    end

    def bags_containing(b)

        @regulations.count {|k,v| ! v.has_key?('none') && bag_trace(b,k) }

    end

end

luggage = LuggageRegulations.new(File.read('../../input/day-07/input'))

p luggage.bags_containing('shiny_gold')

