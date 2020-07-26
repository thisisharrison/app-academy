require "byebug" 

def all_words_capitalized?(array)
    array.all? { |word| word.capitalize == word }

    # array.all? {|word| 
    #     if word.capitalize == word
    #         true
    #     else
    #         false
    #     end
    # }
end

def no_valid_url?(array)
    endings = ['.com', '.net', '.io', '.org']

    array.none? do |url| # false if right endings (if there are true)
        endings.any? { |ending| url.end_with?(ending) } # true if right endings
    end

    # array.none? {|url| 
    #     dot = url.index(".") # get dot position
    #     endings.include?(url[dot..-1])
    # }
end

def any_passing_students?(array)
    array.any? {|student| pass_grade?(student)}
end

def pass_grade?(student)
    total = student[:grades].sum
    classes = student[:grades].length
    average = total / classes * 1.0
    average >= 75.0
end