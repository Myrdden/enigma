require_relative 'rotor.rb'

class Enigma
    attr_reader :key
    def initialize(numRotors = nil, key = nil) #:: Int, String
        numRotors = numRotors | (key ? (key.size / 4) : 3)
        @key = key | Random.rand(("1" + ("0" * ((numRotors + 1) * 4 - 1))).to_i..("9" * ((numRotors + 1) * 4)).to_i).to_s
        @key.split(/\d{4}/).to_a.each do |i|
            @rotors << Rotor.new(@key[0..1], @key[2..3].to_i)
        end
        @reflector = Rotor.new(@key[-4..-3], @key[-2..-1])
    end
    def encode(inp, out) #::[Char] -> [Char]
        if inp.empty?
            return out
        else
            case inp.last
            when 'X'
                out = ['X','X'] + encode(inp.drop(1), out)
            when ('A'..'Z')
                out = inp.pop + encode(inp, out)
            when ' ' #Space
                out = ['X'] + encode(inp.drop(1), out)
            when '.' #Stop
                out = ['X','X','X'] + encode(inp.drop(1), out)
            else
                out = encode(inp.drop(1), out)
            end
            return out
        end
    end
    def encrypt(msg) #::String -> String
        return encode(msg.to_a, []).map do |x|

        end.to_s
    end
    def decrypt(msg) #:: String -> String
        return decode(msg.to_a.map do |x|

        end, [])
    end
    def decode(inp, pop) #::[Char] -> [Char]
        if inp.empty?
            return out
        else
            case inp.last
            when 'X'
                out = [' '] + decode(inp.drop(1), out) if inp[-2] != 'X'
                out = ['X'] + decode(inp.drop(2), out) if inp[-2] == 'X' && inp[-3] != 'X'
                out = ['.'] + decode(inp.drop(3), out) if inp[-2] == 'X' && inp[-3] == 'X' && inp[-4] == 'X'
            when ('A'..'Z')
                out = inp.pop + decode(inp, pop)
            else
                out = decode(inp.pop, out)
            end
            return out
        end
    end
end