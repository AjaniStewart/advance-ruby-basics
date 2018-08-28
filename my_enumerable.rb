module Enumerable
    def my_each
        i = 0
        while i < self.length
            yield(self[i])
            i += 1
        end
        self
    end

    def my_each_with_index
        i = 0
        while i < self.length
            yield(self[i],i)
            i += 1
        end
        self
    end

    def my_select
        arr = []
        self.my_each do |item|
            arr << item if yield(item)
        end
        arr
    end

    def my_all?
        self.my_each do |item|
            return false unless yield(item)
        end
        true
    end

    def my_any?
        self.my_each do |item|
            return true if yield(item)
        end
        false
    end

    def my_none?
        !(self.my_any? {|item| yield(item)})
    end

    def my_count arg=nil
        if !(arg.nil?)
            i = 0
            self.my_each do |item|
                i += 1 if item == arg
            end
            return i
        elsif block_given?
            return self.my_select {|item| yield(item)}.length
        else
            i = 0
            self.my_each {|item| i += 1}
            i
        end
    end

    def my_map &proc
        arr = []
        self.my_each {|item| arr << (proc.nil? ? yield(item) : proc.call(item))}
        arr
    end

    def my_inject inital=nil, sym=nil
        if inital && sym
            self.my_each do |item|
                inital = item.method(sym).call(inital)
            end
        elsif inital && sym.nil? && !block_given?
            sym = inital
            inital = self.first
            self[1..-1].my_each do |item|
                inital = item.method(sym).call(inital)
            end
        elsif block_given?
            arr = []
            if inital.nil?
                inital = self.first
                arr = self[1..-1]
            else
                arr = self
            end
            arr.my_each do |item|
                inital = yield(inital,item)
            end
        else
            raise ArgumentError, "Incorrect arguments given" 
        end

        inital
    end
end

def multiply_els arr
    arr.my_inject(:*)
end
a = (5..10).to_a
square = Proc.new do |x|
    x ** 2
end

p multiply_els [2,4,5]
p a.my_map {|x| x**2}
p a.my_map &square