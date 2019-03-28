require './lib/decor/rec'
require './lib/rotor'
require './lib/stecker'

class Enigma
  extend TailRec
  attr_reader :key
  def initialize(numRotors = nil, key = nil) #:: Int, String
    numRotors = numRotors || (key ? (key.size / 4) : 3)
    @key = key || generate_key(numRotors)
    @key.split(/\d{4}/).to_a.each do |i|
    @rotors << Rotor.new(@key[0..1], @key[2..3].to_i)
    end
    @reflector = Rotor.new(@key[-4..-3], @key[-2..-1].to_i)
  end

  def generate_key(numRotors) #:: Int -> Int
    return Random.rand(("1"+("0" * ((numRotors + 1) * 4 - 1))).to_i\
                         ..("9" * ((numRotors + 1) * 4)).to_i).to_s
  end

  rec def encode(inp, out) #::String -> String
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
      #Pass into stecker
      @rotors.each {|i| i.forward(x)}
      x = @reflector.forward(x)
      j = 0
      @rotors.each do |i|
        x = i.reverse(x)
        steps[j+1] = i.step if steps[j]
        j += 1
      end
      #Pass out of stecker
    end.to_s
  end
  def decrypt(msg) #:: String -> String
    steps = @rotors.map {|x| false}
    steps[0] = true
    return decode(msg.to_a.map do |x|
      #Pass into stecker
      @rotors.each {|i| i.reverse(x)}
      x = @reflector.reverse(x)
      j = 0
      @rotors.each do |i|
        x = i.forward(x)
        steps[j+1] = i.step if steps[j]
        j += 1
      end
      #Pass out of stecker
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
        out = inp.pop + decode(inp, out)
      else
        out = decode(inp.pop, out)
      end
      return out
    end
  end
end