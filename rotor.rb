class Rotor
    def initialize(key, date)
        @key = key
        @setting = spool(("a".."z").to_a, 0, [])
        tmp = (date**2).to_s
        @notches = [tmp[-2..-1], tmp[-4..-3], tmp[-6..-5], tmp[-8..-7]]
        @current = 0
        require 'pry';binding.pry
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
    def step
        forward = @notches.any? {|x| @setting[@current] == x} ? true : false
        @current += 1
        @current = 0 if @current > 25
        return forward
    end
end

test = Rotor.new(5, 101010)