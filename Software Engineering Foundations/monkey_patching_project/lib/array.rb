# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array

    def span
        return nil if self.empty? # Array#empty = length == 0
        return self.max - self.min
    end

    def average
        return nil if self.empty?
        return self.sum / self.length.to_f
    end

    def median
        return nil if self.empty?
        sorted = self.sort
        mid_idx = self.length / 2

        if self.length.odd?             # eg. length is 5, mid index = 5/2 = 2 [0..1..*2*..3..4]
            return sorted[mid_idx]
        else
            mid_2 = mid_idx - 1         # eg. length is 4, mid index = 4/2 = 2 [0..*1..2*..3]
            return (sorted[mid_idx] + sorted[mid_2]) / 2.0
        end
    end

    def counts
        hash = Hash.new(0)
        self.each do |ele|
            hash[ele] += 1
        end
        hash 
    end

    def my_count(element)
        count_hash = self.counts 
        count_hash[element]
    end

    def my_index(element)
        return nil if !self.include?(element)
        self.each_with_index do |ele, i| 
            if element == ele
                return i
            end
        end
    end

    def my_uniq
        self.counts.keys # using has built above

        # unique = {}
        # self.each { |ele| unique[ele] = true } # just assign true to each hash element 
        # unique.keys

        # unique = []
        # self.each do |ele|
        #     if !unique.include?(ele)
        #         unique << ele
        #     end
        # end
        # unique
    end

    def my_transpose
        result = []
        length = self.length
        i = 0

        while i < length 
            row = []
            (0...length).each do |k| 
                row << self[k][i] # first index keep incrementing, second index fixed at 0, then 1, then... (see map below); also flipping rows (i) and columns (k)
            end
            result << row
            i += 1
        end

        result

        # transponse = []
        # length = self.length

        # self.each_with_index do |ele1, idx_1|
        #     row = []

        #     ele1.each_with_index do |ele2, idx_2|
        #         row << self[idx_2][idx_1]
        #     end

        #     transponse << row
        # end

        # transponse



        # original
        # 0.0 0.1 0.2
        # 1.0 1.1 1.2
        # 2.0 2.1 2.2

        # result
        # 0.0 1.0 2.0 
        # 0.1 1.1 2.1
        # 0.2 1.2 2.2

    end

end
