class Verse
    @passage_words
    @passage

    def initialize(file_name)
        @passage_words = File.read(file_name).split
        @passage = @passage_words.join(' ')
    end

    def return_passage
        @passage
    end

    def return_passage_words
        @passage_words
    end
end

class VerseTest
    @passage_words
    @percent_chance
    @passage_blanked

    def initialize(passage_words, percent_chance)
        @passage_words   = passage_words
        @percent_chance  = percent_chance
    end

    def make_blanks
        num = 0
        for i in 0..(@passage_words.count - 1) do
            is_blank = rand(1..100) <= @percent_chance
            num += 1 if is_blank
            word = @passage_words[i]
            @passage_words[i] = (("#{num})") + ('_' * word.length)) if is_blank
        end
        @passage_blanked = @passage_words.join(' ')
    end

    def return_word_array
        @passage_words
    end

    def return_passage_blanked
        @passage_blanked
    end
end

file_name = '2Cor3;16-4;3.txt'

done = false
while !done
    system 'cls'

    puts 'Verses:'
    puts Dir.glob("*.txt")
    print "Verse: "
    STDOUT.flush
    file_name = gets.chomp
    if (!(file_name.include? '.txt'))
        file_name = file_name + '.txt'
    end

    system 'cls'

    verse = Verse.new(file_name)
    puts verse.return_passage

    puts "\nThis verse? (y/n)"
    STDOUT.flush
    done = true if (gets.chomp.downcase.include? 'y')
end

done = false
while !done
    system 'cls'
    
    print 'Percent chance for a blank: '
    percent_blank = gets.chomp.to_i

    system 'cls'

    puts "This percent (y/n): #{percent_blank} %"
    STDOUT.flush
    done = true if (gets.chomp.downcase.include? 'y')
end

system 'cls'

verse_test = VerseTest.new(verse.return_passage_words, percent_blank)
verse_test.make_blanks
puts verse_test.return_passage_blanked