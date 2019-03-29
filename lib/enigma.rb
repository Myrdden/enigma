require './lib/decor/rec'
require './lib/decor/sym-with-args'
require './lib/rotor'
require './lib/stecker'

class Enigma
  extend TailRec

  X_CODES = {'\s' => "X", 'X' => "XX", '.' => "XXX"}

  attr_reader :key
  def initialize(numRotors = nil, key = nil) #:: Int, String
    numRotors = numRotors || (key ? (key.size / 4) : 3)
    @key = key || generate_key(numRotors)
    @key.split(/\d{4}/).to_a.each \
      {|i| @rotors << Rotor.new(i[0..1], i[2..3].to_i)}
    @reflector = Rotor.new(@key[-4..-3], @key[-2..-1].to_i)
  end

  def generate_key(numRotors) #:: Int -> Int
    return Random.rand(("1" + ("0" * ((numRotors + 1) * 4 - 1))).to_i\
                           ..("9" * ((numRotors + 1) * 4)).to_i).to_s
  end

  rec def encode(inp, out) #::String -> String
    return out if inp.empty?
    x, *xs = inp
    case x
    when /[X\s.]/
      out << X_CODES[x]
    when ('A'..'Z')
      out << x
    end
    encode(xs, out)
  end

  rec def decode(inp, out) #::String -> String
    return out if inp.empty?
    x, *xs = inp
    case x
    when ('A'..'Z')
      out << x
    when 'X'
      if xs[-1] == 'X'
        if xs[-2] == 'X'
          out << '.'
          xs = xs[2..-1]
        else
          out << 'X'
          xs = xs[1..-1]
        end
      else
        out << ' '
      end
    end
    decode(xs, out)
  end

  # def encrypt(msg) #::String -> String
  #   xs = encode(msg.to_a, [])
  #   return _encrypt(xs, []).to_s
  # end

  rec def encrypt(inp, out)
    return out if inp.empty?
    x, *xs = inp
    #pass into stecker
    @rotors.each(&:forward.(x))
    x = @reflector.forward(x)
    step = true
    @rotors.each do |r|
      x = r.reverse(x)
      step = r.step! if step
    end
    #pass out of stecker
    encrypt(xs, out)
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
end