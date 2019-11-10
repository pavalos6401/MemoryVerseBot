# Class for creating verses
class Verse
    # Instance variables
    @passage_words
    @passage

    # Initializing Verse
    def initialize(file_name)
        # Read the verse file and create a string array
        @passage_words = File.read(file_name).split
        # Create a string that combines the array (for printing purposes)
        @passage = @passage_words.join(' ')
    end

    # Return the string of the passage
    def return_passage
        # String of the passage
        @passage
    end

    # Return the string array of every word in the passage
    def return_passage_words
        # Array of every word in the passage
        @passage_words
    end
end

# Class for creating the blanks
class VerseTest
    # Instance variables
    @passage_words
    @percent_chance
    @passage_blanked

    # Initializing VerseTest
    def initialize(passage_words, percent_chance)
        # String array of the passage
        @passage_words  = passage_words
        # Chance for the word to be a blank
        @percent_chance = percent_chance
    end

    # Make blanks in the verse
    def make_blanks
        # Number for the blank
        num = 0
        # Loop to determine if the word becomes a blank
        for i in 0..(@passage_words.count - 1) do
            # Boolean to determine if the word becomes a blank
            is_blank = rand(1..100) <= @percent_chance
            # The word is the string at the current position i
            word = @passage_words[i]
            # Word becomes a blank
            if is_blank
                # Number increases if the word will be a blank
                num += 1
                # The word becomes a numerated blank
                @passage_words[i] = (("#{num})") + ('_' * word.length))
            end
        end
        # Create a string from the now-blanked string array of the words
        @passage_blanked = @passage_words.join(' ')
    end

    # Return a string of the blanked passage
    def return_passage_blanked
        # String of the blanked passage
        @passage_blanked
    end
end

# Loop to select passage
done = false
while !done
    # Clear console
    system 'cls'

    # Display available txt files of verses
    puts 'Verses:'
    puts Dir.glob("*.txt")

    # Select verse from above list
    print "Verse: "
    STDOUT.flush
    file_name = gets.chomp
    # If the user enters the name without the .txt file type, then add it
    if (!(file_name.include? '.txt'))
        file_name = file_name + '.txt'
    end

    # Clear console
    system 'cls'

    # Create a new verse using above information
    verse = Verse.new(file_name)

    # Confirm verse selection
    puts verse.return_passage
    puts "\nThis verse? (y/n)"
    STDOUT.flush
    done = true if (gets.chomp.downcase.include? 'y')
end

# Loop to select percent chance for a blank
done = false
while !done
    # Clear console
    system 'cls'
    
    # Select integer percent chance
    print 'Percent chance for a blank: '
    percent_blank = gets.chomp.to_i

    # Clear console
    system 'cls'

    # Confirm selection
    puts "This percent (y/n): #{percent_blank} %"
    STDOUT.flush
    done = true if (gets.chomp.downcase.include? 'y')
end

# Clear console
system 'cls'

# Create a new verse test using above information
verse_test = VerseTest.new(verse.return_passage_words, percent_blank)
# Make blanks in the passage
verse_test.make_blanks
# Display the passage with blanks
puts verse_test.return_passage_blanked