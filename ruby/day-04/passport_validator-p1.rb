#! /usr/bin/env ruby

class PassportObject

    def initialize(raw)

        fields(**Hash[comprehend(raw)]).each do |k,v|

            instance_variable_set("@#{k}", v)

            define_singleton_method(k.to_sym) { self.instance_variable_get("@#{k}".to_sym) }

        end

    end

    def comprehend(r)

        r.split(/\s/)
         .reject(&:empty?)
         .map {|str| str.split(':').map.with_index {|fld, i| i == 0 ? fld.to_sym : fld} }

    end

    def fields(byr: nil, iyr: nil, eyr: nil, hgt: nil, hcl: nil, ecl: nil, pid: nil, cid: nil)

        method(__method__).parameters.each_with_object({}) do |prm,hash|

            name = prm[1]

            hash[name.to_s] = binding.local_variable_get(name)

        end

    end

    def valid?()

        instance_variables.reject {|v| v == :@cid }.none? do |pass|

            instance_variable_get(pass).nil?

        end

    end

end

passports = File.read('../../input/day-04/input').split(/^$/).map {|l| PassportObject.new(l)}

p passports.count {|pass| pass.valid? }

