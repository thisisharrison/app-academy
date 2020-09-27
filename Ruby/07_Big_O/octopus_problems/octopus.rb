# A Very Hungry Octopus wants to eat the longest fish in an array of fish.

fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# => "fiiiissshhhhhh"

# Sluggish Octopus = quadratic search = O(n^2) time
# nested loops
def quadratic(fish)
    # compares each fish with one another. using f1 as target (longest to beat)
    fish.each_with_index do |f1, i1|
        max_length = true
        fish.each_with_index do |f2, i2|
            next if i1 == i2
            max_length = false if f2.length > f1.length
        end
        return f1 if max_length
    end
end

puts "Quadratic Search > " + quadratic(fish)

# Dominate Octopus = O(n log n) time
# merge sort, quick sort
class Array
    def merge_sort(&prc)
        # sorting proc <=> 
        prc ||= Proc.new { |x, y| x <=> y }
        return self if count == 1
        half_idx = count / 2

        left = self.take(half_idx).merge_sort(&prc)
        right = self.drop(half_idx).merge_sort(&prc)

        
        Array.merge(left, right, &prc)
    end

    def quick_sort
        return self if length <= 1
        pivot = [self.first]
        # sorts smallest to largest 
        left = self[1..-1].select { |el| el.length < pivot.length }
        right = self[1..-1].select { |el| el.length >= pivot.length }
        left.quick_sort + pivot + right.quick_sort
    end

    private 
    def self.merge(left, right, &prc)
        merged = []
        until left.empty? || right.empty?
            # calls the <=> from merge sort, sorts smallest to largest
            case prc.call(left.first, right.first) 
            when -1
                # shift = remove first element
                merged << left.shift
            when 0
                merged << left.shift
            when 1
                merged << right.shift
            end
        end
        merged.concat(left).concat(right)
    end
end

def logarithmic(fish)
    # sorts the array longest to shortest (y first)
    prc = Proc.new{ |x, y| y.length <=> x.length }
    fish.merge_sort(&prc)[0]
end

def quick_sort(fish)
    fish.quick_sort[-1]
end

puts "Merge Sort > " + logarithmic(fish)
puts "Quick Sort > " + quick_sort(fish)

# Clever octopus = linear = O(n) time
# Runs through the array length once 
def linear(fish)
    longest = ''
    fish.each do |f|
        next if f.length <= longest.length
        longest = f
    end
    longest
end

puts "Linear Search > " + linear(fish)


# Dancing Octopus
# Full of fish, the Octopus attempts Dance Dance Revolution. The game has tiles in the following directions:

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
# To play the game, the octopus must step on a tile with her corresponding tentacle. We can assume that the octopus's eight tentacles are numbered and correspond to the tile direction indices.

# Slow Dance
# O(n) time
def slow_dance(cue, tiles_array)
    return '' unless tiles_array.include?(cue)
    tiles_array.each_with_index do |el, i|
        return i if cue == el
    end
end

puts slow_dance("up", tiles_array)
# > 0
puts slow_dance("right-down", tiles_array)
# > 3

# Constant Dance!
# O(1) time
tiles_hash = {
    "up" => 0,
    "right-up" => 1,
    "right"=> 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
}

def constant_dance(cue, tiles_hash)
    tiles_hash[cue]
end

puts constant_dance("up", tiles_hash)
# > 0
puts constant_dance("right-down", tiles_hash)
# > 3
