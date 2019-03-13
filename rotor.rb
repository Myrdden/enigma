class Rotor
    def initialize(key)
        @key = key
        @setting = spool(("a".."z").to_a, 0, [])
        puts @setting
    end
    def spool(inp, i, out)
        if inp.empty?
            return out
        else
            i = (i + @key) % inp.size
            out.push(inp.slice!(i))
            return spool(inp, i, out)
        end
    end
end

test = Rotor.new(5)