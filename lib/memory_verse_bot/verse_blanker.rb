# Class for creating the blanks
class VerseBlanker
    # Constants
    # Marks that only appear at the end of the word
    END_MARKS = [',', '.', ';', ':', '?', '!', ')', "\u201d"]
    # Marks that only appear at the start of the word
    START_MARKS = ['(', "\u201c"]

    # Instance variables
    @passage_words
    @percent_chance
    @num
    @answers
    @passage_blanked

    # Initialize VerseBlanker
    def initialize
        # String array of the passage
        @passage_words = Array.new
        # Chance for the word to be a blank
        @percent_chance = 0
        # Number for the blank (0 when beginning)
        @num = 0
        # Array of answers to the blanks
        @answers = Array.new
        # Passage string with balnks
        @passage_blanked = ''
    end

    # Get the string array of the passage
    def passage_words=(passage_words)
        # String array of the passage
        @passage_words = passage_words
    end

    # Get the chance for each word to become a blank
    def percent_chance=(percent_chance)
        # Chance for the word to be a blank
        @percent_chance = percent_chance
    end

    # Make blanks in the verse
    def make_blanks
        # Loop to determine if the word becomes a blank
        for i in 0..(@passage_words.length - 1) do
            # The word is the string at the current position i
            word = @passage_words[i]
            # Boolean to determine if the word becomes a blank (biased for words bigger than 3 letters)
            is_blank = (rand(1..100) - word.length + 3) <= @percent_chance
            # Word becomes a blank
            if is_blank
                # Number increases if the word will be a blank
                @num += 1
                # Find the punctuation or other marks in the word
                word_marks = check_for_marks(word)
                # The answer to the blank is the word without the marks
                @answers[@num - 1] = remove_marks(word, word_marks)
                # Make the word a blank
                word = "#{@num})#{'_' * @answers[@num - 1].length}"
                # If there are any marks at the start of the word, then add them to the beginning of the blank
                word = "#{word_marks[1]}#{word}" if word_marks[1].length > 0
                word = "#{word_marks[0]}#{word}" if word_marks[0].length > 0
                # If there are any marks at the end of the word, then add them to the end of the blank
                word = "#{word}#{word_marks[-2] + word_marks[-1]}" if word_marks[-2..-1].length > 0
            end
            # Save the word as the new passage word
            @passage_words[i] = word
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

    private

    # Check for puncuation marks or quotation marks, or other marks
    def check_for_marks(word)
        # Convert the word into an array
        word = word.split('')
        # Marks in the word
        word_marks = Array.new(word.length, '')
        # Check for end marks
        for i in 0..(END_MARKS.length - 1) do
            if word.include? END_MARKS[i]
                # Find where it is located
                location = word.index(END_MARKS[i])
                # Save the mark
                word_marks[location] = END_MARKS[i]
            end
        end
        # Check for start marks
        for i in 0..(START_MARKS.length - 1) do
            if word.include? START_MARKS[i]
                # Find where it is located
                location = word.index(START_MARKS[i])
                # Save the mark
                word_marks[location] = START_MARKS[i]
            end
        end
        # Return the array defining the location of the marks
        word_marks
    end

    # Return the sum of how many marks there are in the word
    def number_marks(word_marks)
        # Sum of how many marks there are
        sum = 0
        for i in 0..(word_marks.length - 1) do
            sum += 1 if word_marks[i].length > 0
        end
        # Return the sum
        sum
    end

    # Remove the marks from a word
    def remove_marks(word, word_marks)
        # Convert word into an array
        word = word.split('')
        # Remove the marks from the word
        for i in 0..(word.length - 1) do
            word[i] = '' if word_marks[i].length > 0
        end
        # Return word string without the marks
        word.join('')
    end
end