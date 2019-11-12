# Class for creating the blanks
class VerseBlanker
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
                # Make the word a blank
                @passage_words[i] = "#{@num})#{'_' * (word.length - 1)}"
                # Check if there is any punctuation or quotation mark in the word
                if word.include? '.'
                    # If there is a period, then add the period at the end of the blank
                    @passage_words[i] = @passage_words[i].rjust(1, '.')
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].sub('.', '')
                elsif word.include? ','
                    # If there is a comma, then add the comma at the end of the blank
                    @passage_words[i] = @passage_words[i].rjust(1, ',')
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].sub(',', '')
                elsif word.include? ';'
                    # If there is semicolon, then add the semicolon at the end of the blank
                    @passage_words[i] = @passage_words[i].rjust(1, ';')
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].sub('.', '')
                elsif word.include? ':'
                    # If there is colon, then add the colon at the end of the blank
                    @passage_words[i] = @passage_words[i].rjust(1, ':')
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].sub('.', '')
                elsif word.include? '!'
                    # If there is an exclamation mark, then add the exclamation mark at the end of the blank
                    @passage_words[i] = @passage_words[i].rjust(1, '!')
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].sub('!', '')
                elsif word.include? '?'
                    # If there is a question mark, then add the question mark at the end of the blank
                    @passage_words[i] = @passage_words[i].rjust(1, '?')
                    # Remove the punctuation from the answer key
                    @answers[@num - 1] = @answers[@num - 1].sub('?', '')
                elsif word.index("\"") == 0
                    # If there is a quotation mark at the start, then add the quotation mark at the start of the blank
                    @passage_words[i] = @passage_words[i].ljust(1, "\"")
                    # Remove the quotation mark from the answer key
                    @answers[@num - 1] = @answers[@num - 1].sub("\"", '')
                elsif word.index("\"") == -1
                    # If there is a quotation mark at the end, then add the quotation mark at the end of the blank
                    @passage_words[i] = @passage_words[i].rjust(1, "\"")
                    # Remove the quotation mark from the answer key
                    @answers[@num - 1] = @answers[@num - 1].sub("\"", '')
                else
                    # If there is no punctuation then it just becomes a blank
                    @passage_words[i] = @passage_words[i].rjust(1, '_')
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