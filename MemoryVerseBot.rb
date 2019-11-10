# Class for creating verses
class VerseMaker
    # Instance variables
    @passage_words
    @passage

    # Initializing VerseMaker
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
class VerseBlanker
    # Instance variables
    @passage_words
    @percent_chance
    @num
    @answers
    @passage_blanked

    # Initializing VerseBlanker
    def initialize(passage_words, percent_chance)
        # String array of the passage
        @passage_words = passage_words
        # Chance for the word to be a blank
        @percent_chance = percent_chance
        # Number for the blank (0 when beginning)
        @num = 0
        # Array of answers to the blanks
        @answers = Array.new
        # Passage string with balnks
        @passage_blanked = ''
    end

    # Make blanks in the verse
    def make_blanks
        # Loop to determine if the word becomes a blank
        for i in 0..(@passage_words.length - 1) do
            # Boolean to determine if the word becomes a blank
            is_blank = rand(1..100) <= @percent_chance
            # The word is the string at the current position i
            word = @passage_words[i]
            # Word becomes a blank
            if is_blank
                # Number increases if the word will be a blank
                @num += 1
                # Save the answer to the blank
                @answers[@num - 1] = word
                # Check if there is any punctuation in the word
                if word.include? '.'
                    # If there is a period, then add the period at the end of the blank
                    @passage_words[i] = "#{@num})#{'_' * (word.length - 1)}."
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].gsub('.', '')
                elsif word.include? ','
                    # If there is a comma, then add the comma at the end of the blank
                    @passage_words[i] = "#{@num})#{'_' * (word.length - 1)},"
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].gsub('.', '')
                elsif word.include? ';'
                    # If there is semicolon, then add the semicolon at the end of the blank
                    @passage_words[i] = "#{@num})#{'_' * (word.length - 1)};"
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].gsub('.', '')
                elsif word.include? ':'
                    # If there is colon, then add the colon at the end of the blank
                    @passage_words[i] = "#{@num})#{'_' * (word.length - 1)}:"
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].gsub('.', '')
                else
                    # If there is no punctuation then it just becomes a blank
                    @passage_words[i] = "#{@num})#{'_' * word.length}"
                end
            end
        end
        # Create a string from the now-blanked string array of the words
        @passage_blanked = @passage_words.join(' ')
    end

    # Return the answer key
    def return_answers
        # Answer key array
        @answers
    end

    # Return a string of the blanked passage
    def return_passage_blanked
        # String of the blanked passage
        @passage_blanked
    end
end

# Class to test if the input is correct
class VerseTester
    # Instance Variables
    @passage_blanked
    @answers
    @points
    @grade

    # Initializing VerseTester
    def initialize(passage_blanked, answers)
        # Blanked passage
        @passage_blanked = passage_blanked
        # Answers to the blanks
        @answers = answers
        # Array of points for the user
        @points = Array.new(@answers.length, 0)
        # Grade value from 0-100
        @grade = 0
    end

    # Check if input matches the answer
    def check_input(input, num)
        # Get a point for answering it correctly
        @points[num - 1] = 1 if input.downcase == @answers[num - 1].downcase
    end

    # Fill in blanks of the passage with user's input
    def fill_in_blank(input, num)
        # Replace the blank with the user's input
        @passage_blanked = @passage_blanked.gsub("#{num})#{'_' * @answers[num - 1].length}", "#{num})#{input}")
    end

    # Return the passage with the user's inputs
    def return_filled_passage
        # Blanked passage, if fill_in_blank was run before this then the blank becomes the input
        @passage_blanked
    end

    # Grade the test
    def grade_test
        # Add up all the points
        sum = 0
        for i in 0..(@points.length - 1) do
            sum += @points[i]
        end
        # Grade is equal to the sum divided by the total points, and then multiplied by 100 to convert to a percentage
        @grade = (sum.to_f / @points.length) * 100
    end

    # Return a value from 0 to 100 for a grade
    def return_grade
        # Grade value from 0-100
        @grade
    end
end

# Loop to select passage
done = false
while !done
    # Clear console
    system 'cls'

    # Display available txt files of verses
    puts 'Verses:'
    puts Dir.glob('*.txt')

    # Select verse from above list
    print "\nVerse: "
    STDOUT.flush
    file_name = gets.chomp.to_s
    # If the user enters the name without the .txt file type, then add it
    file_name = file_name + '.txt' if ! file_name.include? '.txt'

    # Clear console
    system 'cls'

    # Create a new verse using above information
    verse_maker = VerseMaker.new(file_name)

    # Confirm verse selection
    puts verse_maker.return_passage
    puts "\nThis verse? (y/n)"
    STDOUT.flush
    done = true if gets.chomp.downcase.include? 'y'
end

# Loop to select percent chance for a blank
done = false
while !done
    # Clear console
    system 'cls'
    
    # Select integer percent chance
    print 'Percent chance for a blank (integer from 0 to 100): '
    STDOUT.flush
    percent_chance = gets.chomp.to_i

    # Clear console
    system 'cls'

    # Confirm selection
    puts "This percent (y/n): #{percent_chance} %"
    STDOUT.flush
    done = true if gets.chomp.downcase.include? 'y'
end

# Clear console
system 'cls'

# Create a new verse blanker using above information
verse_blanker = VerseBlanker.new(verse_maker.return_passage_words, percent_chance)
# Make blanks in the passage
verse_blanker.make_blanks

# Create a new verse tester using above information
verse_tester = VerseTester.new(verse_blanker.return_passage_blanked, verse_blanker.return_answers)

# Loop to test the user
for i in 1..verse_blanker.return_answers.length do
    # Loop to get user's input on the current blank
    done = false
    while !done
        #Clear console
        system 'cls'

        # Display the passage with blanks
        puts verse_tester.return_filled_passage

        # Display current blank and get user input
        print "\n#{i}) "
        STDOUT.flush
        input = gets.chomp.to_s

        # Confirm answer
        puts "\nConfirm that '#{input}' is your answer (y/n)"
        STDOUT.flush
        done = true if gets.chomp.downcase.include? 'y'
    end

    # Check if the input was correct
    verse_tester.check_input(input, i)

    # Fill in blank with user's input
    verse_tester.fill_in_blank(input, i)
end

# Grade test
verse_tester.grade_test

# Clear console
system 'cls'

# Display your passage 
puts 'Your input:'
puts verse_tester.return_filled_passage

# Display actual passage
puts "\nActual verse:"
puts verse_maker.return_passage

# Display final grade
puts "\nYour final grade is: #{verse_tester.return_grade} %"