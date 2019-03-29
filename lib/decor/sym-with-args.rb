class Symbol
  def call(*args, &block)
    Proc.new{|obj, *default| obj.send(self, *(other + args), &block)}
  end
end