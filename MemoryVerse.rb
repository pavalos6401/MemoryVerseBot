class Verse
    @passage = ''

    def initialize(file_name)
        @passage = File.readlines(file_name)
    end

    def return_passage
        @passage
    end
end

class BlanksMaker
    @passage       = ''
    @percent_blank
    @passage_words

    def initialize(passage, percent_blank)
        @passage       = passage
        @percent_blank = percent_blank
        @passage_words = @passage.split(/[^[[:word:]]']+/)
    end

    def return_blanked_passage
        
    end

    private

    def make_blanks

    end
end

done = false
while !done
    system 'cls'

    puts 'Verses:'
    puts Dir.glob("*.txt")
    print 'Verse: '
    STDOUT.flush
    file_name = gets.chomp
    if (! (file_name.include? '.txt'))
        file_name = file_name + '.txt'
    end

    system 'cls'

    verse = Verse.new(file_name)
    puts verse.return_passage

    puts "\nThis verse? (y/n)"
    STDOUT.flush
    done = true if (gets.chomp.downcase.include? 'y')
end
print 'Percent blank (double 0-1): '
percent_blank = gets.chomp.to_f
blankMaker = BlanksMaker.new(verse.return_passage)

