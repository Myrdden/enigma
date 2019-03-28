class Rotor
    def initialize(key, initial) #:: String, Int
      @key = key
      @initial = initial % 26
      @setting = spool_I(("A".."Z").to_a, 0, [])
      @notches = generate_notches(@key, @initial)
      @current = @initial
    end

    def generate_notches(key, initial) #:: String, Int -> Int, Int
      notchA = (key.to_i * initial) % 26
      notchB = (((key[1].to_i * 10) + key[0].to_i) * initial) % 26
      notchB = (notchB + 13) % 26 if notchA == notchB
      return [notchA, notchB]
    end

    def spool_I(inp, i, out)
        if inp.empty?
            return out
        else
            i = (@key[0].to_i.even? ? (i + @key.to_i) : (i - @key.to_i)) % inp.size
            out.push(inp.slice!(i))
            return spool_I(inp, i, out)
        end
    end
    def spool_II()
        if inp.empty?
            return out
        else

        end
    end
    def spool_III()

    end
    def spool_IV()

    end
    def spool_V()

    end

    def forward(inp) #:: Int -> Int
      {return @setting[(inp - 65)]}

    def reverse(inp) #:: Int -> Int
      {return (@setting.index(inp) + 65)}

    def step!
      forward = @notches.any? {|x| @setting[@current] == x} ? true : false
      @current += 1
      @current = 0 if @current > 25
      return forward
    end

    def reset!
      @current = @initial
    end
end