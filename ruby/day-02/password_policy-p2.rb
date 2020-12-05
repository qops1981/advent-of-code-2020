#! /usr/bin/env ruby

PW_PL = File.read('../../input/day-02/input').split("\n")

PasswordPolicy = Struct.new(:range_string, :char, :password) do

    def range() range_string.split('-').map(&:to_i) end

    def valid?() pw_char?(range[0]) ^ pw_char?(range[1]) end

    def pw_char?(pos) password[pos - 1] == char end

end

def policy(s) PasswordPolicy.new(*s.match(/(\d+-\d+) (\w+): (\w+)/).captures) end

def valid_passwords() PW_PL.count {|pw_pl| policy(pw_pl).valid? } end

p valid_passwords

