require 'set'

class WordChainer

    attr_accessor :current_words, :dictionary

    def initialize(dictionary_file_name)
        @dictionary = read_dict(dictionary_file_name)
    end

    def read_dict(file)
        file_data = Set.new(File.readlines(file).map(&:chomp))
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words = { source => nil }
        while !@current_words.empty? || !@all_seen_words.has_key?(target)
            explore_current_words
        end
        build_path(target)            
    end

    def build_path(target)
        path = []
        current_word = target
        until current_word.nil?
            path << current_word
            # get modified word in the path as it led to target
            current_word = @all_seen_words[current_word]
        end
        path.reverse
    end

    def explore_current_words
        new_current_words = [] 
        @current_words.each do |word|
            adjacent_words = self.adjacent_words(word)
            adjacent_words.each do |adj_word|
                next if @all_seen_words.has_key?(adj_word)
                new_current_words << adj_word
                # record which previous word we modified to get new word
                # adj word as key to record where current word came from
                @all_seen_words[adj_word] = word
            end
        end
        @current_words = new_current_words

        # new_current_words.each do |current_word|
        #     puts "#{@all_seen_words[current_word]} => #{current_word}"
        # end
    end

    def adjacent_words(word)
        same_length_words = @dictionary.select { |dict_word| dict_word.length == word.length }
        letters = word.split("")

        adjacent_words = same_length_words.select do |word|
            letter_diff = 0
            letters.each do |char|
                letter_diff += 1 if !word.include?(char)
            end
            if letter_diff > 1
                false
            else
                true
            end
        end

        adjacent_words

    end

end

if __FILE__ == $PROGRAM_NAME
    p WordChainer.new('./dictionary.txt').run('duck','ruby')
end