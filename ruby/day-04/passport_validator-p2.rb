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

    def valid_byr?(byr) byr.length == 4 && byr.to_i.between?(1920, 2002) end

    def valid_iyr?(iyr) iyr.length == 4 && iyr.to_i.between?(2010, 2020) end

    def valid_eyr?(eyr) eyr.length == 4 && eyr.to_i.between?(2020, 2030) end

    def valid_hgt?(hgt)

        measurements = ['cm', 'in']

        height = hgt.match(/(\d+)(cm|in)?/).captures

        return false unless measurements.include?(height[1])

        case height[1]
        when 'cm'
            height[0].to_i.between?(150, 193)
        when 'in'
            height[0].to_i.between?(59, 76)
        else
            false
        end

    end

    def valid_hcl?(hcl) hcl =~ /^#[0-9a-f]{6}$/ end

    def valid_ecl?(ecl) ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(ecl) end

    def valid_pid?(pid) pid =~ /^[0-9]{9}$/ end

    def valid?()

        instance_variables.reject {|v| v == :@cid }.none? do |pass|

            instance_variable_get(pass).nil? ||
                ! send("valid_#{pass.to_s[1..-1]}?", instance_variable_get(pass))

        end

    end

end

passports = File.read('../../input/day-04/input').split(/^$/).map {|l| PassportObject.new(l)}

p passports.count {|pass| pass.valid? }

