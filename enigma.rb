require_relative 'rotor.rb'

class Enigma
    def initialize(numRotors = nil, key = nil) #:: Int, Int
        @key = key | Random.rand(("1" + ("0" * ((numRotors + 1) * 4 - 1))).to_i..("9" * ((numRotors + 1) * 4)).to_i)
        numRotors.times do |i|

        end
        @reflector = Rotor.new()
    end

    def encrypt(msg)
        msg.each_char do |x|

        end
    end
end