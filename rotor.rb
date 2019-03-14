class Rotor
    def initialize(key, initial) #:: String, Int
        @key = key
        @initial = initial % 26
        case key
        when /^[01]/
            @setting = spool_I(("A".."Z").to_a, 0, [])
        when /^[23]/

        when /^[45]/

        when /^[67]/

        when /^[89]/

        end
        @notches =
        @current = @initial
    end
    def spool_I(inp, i, out)
        if inp.empty?
            return out
        else
            i = (@key[0].to_i.even? ? (i + @key.to_i) : (i - @key.to_i)) % inp.size
            out.push(inp.slice!(i))
            return spool(inp, i, out)
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
    def step
        forward = @notches.any? {|x| @setting[@current] == x} ? true : false
        @current += 1
        @current = 0 if @current > 25
        return forward
    end
    def set()
        @current = @initial
    end
    def forward(inp)
        return @setting[(inp.ord - 65)]
    end
    def reverse(inp)
        return (@setting.index(inp) + 65).chr
    end
end