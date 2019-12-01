# Class to test if the input is correct
class VerseTester
    # Instance Variables
    @passage_blanked # The entire blanked passage
    @answers         # The answers to the blanks
    @points          # The points used to determine a grade
    @grade           # The grade of the user
    @inputs          # The answers/inputs of the user

    # Initialize VerseTester
    def initialize
        @passage_blanked = '' # Blanked passage
        @grade = 0            # Grade value from 0-100
    end

    # Get the blanked out passage (for printing purposes)
    def passage_blanked=(passage_blanked)
        @passage_blanked = passage_blanked # Blanked out passage
    end

    # Get the answers
    def answers=(answers)
        # Answers to the blanks
        @answers = answers
        # All the user inputs
        @inputs = Array.new(answers.length, '')
    end

    # Set up the array for points
    def set_up_points
        @points = Array.new(@answers.length, 0) # Array of points for the user
    end
        
    # Check if input matches the answer
    def check_input(input, num)
        # Save the input
        @inputs[num - 1] = input
        # Get a point for answering it correctly
        @points[num - 1] = 1 if input.downcase == @answers[num - 1].downcase
    end

    # Fill in blanks of the passage with user's input
    def fill_in_blank(input, num)
        @passage_blanked = @passage_blanked.sub("#{num})#{'_' * @answers[num - 1].length}", "#{num})#{input}") # Replace the blank with the user's input
    end

    # Return the passage with the user's inputs
    def return_filled_passage
        @passage_blanked # Blanked passage, if fill_in_blank was run before this then the blank becomes the input
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
        @grade # Grade value from 0-100
    end

    # Return all the inputs
    def return_inputs
        @inputs # All the inputted guesses
    end
end
