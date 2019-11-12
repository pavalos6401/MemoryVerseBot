require 'scripture_lookup'
require_relative 'memory_verse_bot/verse_blanker.rb'
require_relative 'memory_verse_bot/verse_maker.rb'
require_relative 'memory_verse_bot/verse_tester.rb'

# Create an instance of VerseMaker class
verse_maker = VerseMaker.new
# Create an instance of VerseBlanker class
verse_blanker = VerseBlanker.new
# Create an instance of VerseTester class
verse_tester = VerseTester.new

# Loop to select passage
done = false
while !done
    # Clear console
    system 'cls'

    # Select passage
    print 'Citation: '
    STDOUT.flush
    citation = gets.chomp.to_s

    # Select version
    print 'Version: '
    STDOUT.flush
    version = gets.chomp
    version = version.upcase.to_sym if version.is_a? String

    # Create a new verse using above information
    verse_maker.look_up_passage(citation, version)

    # Clear console
    system 'cls'

    # Confirm verse selection
    puts verse_maker.return_passage
    puts "#{citation} (#{version.to_s})"
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

# Add above information to VerseBlanker instance
verse_blanker.passage_words = verse_maker.return_passage_words
verse_blanker.percent_chance = percent_chance
# Make blanks in the passage
verse_blanker.make_blanks

# Add above information to VerseTester instance
verse_tester.passage_blanked = verse_blanker.return_passage_blanked
verse_tester.answers = verse_blanker.return_answers
verse_tester.set_up_points

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

gets