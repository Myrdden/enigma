class Rotor
    def initialize(key, date)
        @key = key
        abcs = ("A".."Z").to_a
        tmp = (date**2).to_s
        @notches = [abcs[tmp[-2..-1].to_i], abcs[tmp[-4..-3].to_i], abcs[tmp[-6..-5].to_i], abcs[tmp[-8..-7].to_i]].uniq
        @setting = spool(abcs, 0, [])
        @current = 0
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
    def reset
        @current = 0
    end
    def forward(inp)
        return @setting[(inp.ord - 65)]
    end
    def reverse(inp)
        return (@setting.index(inp) + 65).chr
    end
end

test = Rotor.new(5, 123456)
puts test.forward("C")
puts test.reverse(test.forward("C"))