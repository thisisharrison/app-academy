class Array

    def my_uniq
        self.inject([]) do |result, el|
            result << el unless result.include?(el)
            result
        end
    end

    # Alternatively with hash: 
    # def my_uniq
    #     uniq = Hash.new
    #     self.each do |el|
    #         uniq[el] = true
    #     end
    #     uniq.keys
    # end

    def two_sum
        result = []
        (0..self.length - 1).each do |i|
            (i + 1..self.length - 1).each do |j|
                result << [i, j] if (self[i] + self[j]) == 0
                next
            end
        end
        result
    end

    def my_transpose
        height = self.first.count
        cols = Array.new(height) { Array.new(height) }
        
        height.times do |i|
            height.times do |j|
                cols[i][j] = self[j][i]
            end
        end

        cols
    end

    def pick_stocks
        pair = nil
        best_profit = 0

        self.each_with_index do |buy, b|
            self.each_with_index do |sell, s|
                next if s < b
                profit = sell - buy
                if profit > best_profit
                    pair = [b, s]
                    best_profit = profit
                end
            end
        end
        
        pair
    end

end
