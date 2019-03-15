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
    def encode(inp, out) #::[Char] -> [Char]
        if inp.empty?
            return out
        else
            case inp.last
            when 'X'
                out = ['X','X'] + encode(inp.pop, out)
            when ('A'..'Z')
                out = inp.pop + encode(inp, out)
            when ' ' #Space
                out = ['X'] + encode(inp.pop, out)
            when '.' #Stop
                out = ['X','X','X'] + encode(inp.pop, out)
            else
                out = encode(inp.pop, out)
            end
            return out
        end
    end
    def encrypt(msg) #::String -> String
        encode(msg.to_a, []).map do |x|
            
        end
    end
    def decode(inp, pop) #::[Char] -> [Char]
        if inp.empty?
            return out
        else
            case inp.last
            when 'X'
                out = [' '] + decode(inp.pop, out) if inp[-2] != 'X'
                out = ['X'] + decode(inp.pop.pop, out) if inp[-2] == 'X' && inp[-3] != 'X'
                out = ['.'] + decode(inp.pop.pop.pop, out) if inp[-2] == 'X' && inp[-3] == 'X' && inp[-4] == 'X'
            when ('A'..'Z')
                out = inp.pop + decode(inp, pop)
            else
                out = decode(inp.pop, out)
            end
            return out
        end
    end
end