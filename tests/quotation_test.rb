class MarksTest
    # Constants
    # Marks that only appear at the end of the word
    END_MARKS = [',', '.', ';', ':', '?', '!', ')']
    # Marks that only appear at the start of the word
    START_MARKS = ['(']
    # Marks that appear either at the start or end
    OTHER_MARKS = ["\""]
    def check_for_marks(word)
        # Convert the word into an array
        word = word.split('')
        # Marks in the word
        word_marks = Array.new(word.length, '')
        # Check for end marks
        for i in 0..(END_MARKS.length - 1) do
            if word.include? END_MARKS[i]
                location = word.index(END_MARKS[i])
                word_marks[location] = END_MARKS[i]
            end
        end
        # Check for start marks
        for i in 0..(START_MARKS.length - 1) do
            if word.include? START_MARKS[i]
                location = word.index(START_MARKS[i])
                word_marks[location] = START_MARKS[i]
            end
        end
        # Check for other marks
        for i in 0..(OTHER_MARKS.length - 1) do
            if word.include? OTHER_MARKS[i]
                location = word.index(OTHER_MARKS[i])
                word_marks[location] = OTHER_MARKS[i]
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

OTHER_MARKS = ["\""]

word = gets.chomp.to_s
word_marks = Array.new(word.length, '')
for i in 0..(OTHER_MARKS.length - 1) do
    if word.include? OTHER_MARKS[i]
        location = word.index(OTHER_MARKS[i])
        word_marks[location] = OTHER_MARKS[i]
    end
end
puts word_marks.to_s
puts word_marks[0]

# Convert word into an array
word = word.split('')
# Remove the marks from the word
for i in 0..(word.length - 1) do
    word[i] = '' if word_marks[i].length > 0
end
# Return word string without the marks
puts word.join('')

puts word_marks[0].length
puts word.to_s

marks_test = MarksTest.new

puts "Sum of " + marks_test.number_marks(word_marks).to_s

num = 0
is_blank = true
if is_blank
    word = word.join('')
    # Number increases if the word will be a blank
    num += 1
    # Find the punctuation or other marks in the word
    word_marks = marks_test.check_for_marks(word)
    sum_of_marks = marks_test.number_marks(word_marks) 
    # The answer to the blank is the word without the marks
    answer = marks_test.remove_marks(word, word_marks)
    # Make the word a blank
    word = "#{num})#{'_' * (answer.length)}"
    # If there are any marks at the start of the word, then add them to the beginning of the blank
    word = "#{word_marks[1]}#{word}" if word_marks[1].length > 0
    word = "#{word_marks[0]}#{word}" if word_marks[0].length > 0
    word = "#{word}#{word_marks[-2] + word_marks[-1]}" if word_marks[-2..-1].length > 0
end

puts num
puts answer
puts word.to_s