def bubble_sort arr
    new_arr = arr
    new_arr.length.times do |i|
        (new_arr.length - 1).times do |j|
            new_arr[i],new_arr[j] = new_arr[j],new_arr[i] if new_arr[i] < new_arr[j]
        end
    end    
    new_arr
end

def bubble_sort_by arr
    new_arr = arr
    new_arr.length.times do |i|
        (new_arr.length-1).times do |j|
            new_arr[i],new_arr[j] = new_arr[j],new_arr[i] if yield(new_arr[i],new_arr[j]) < 0
        end
    end
    new_arr
end

p bubble_sort [4,3,78,2,0,2]
p(bubble_sort_by(["hi","hello","hey"]) {|left,right| left.length - right.length })