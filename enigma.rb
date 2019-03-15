require_relative 'rotor.rb'

class Enigma
    attr_reader :key
    def initialize(numRotors = nil, key = nil) #:: Int, String
        numRotors = numRotors | (key ? (key.size / 4) : 3)
        @key = key | Random.rand(("1" + ("0" * ((numRotors + 1) * 4 - 1))).to_i..("9" * ((numRotors + 1) * 4)).to_i).to_s
        numRotors.times do |i|
            @rotors << Rotor.new(@key[()], @key[].to_i)
        end
        @reflector = Rotor.new(@key[-4..-3], @key[-2..-1])
    end

    def encrypt(msg)
        msg.each_char do |x|

        end
    end
end