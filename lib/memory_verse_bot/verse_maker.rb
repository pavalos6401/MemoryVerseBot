# Class for creating verses
class VerseMaker
    # Instance variables
    @provider      # Used to look up the verses
    @passage       # The entire bible passage
    @passage_words # The words in the passage

    # Initialize VerseMaker
    def initialize()
        @provider = ScriptureLookup.new # Initializing 'scripture_lookup' to get Bible verses
    end

    # Find Bible verse
    def look_up_passage(citation, version)
        # Find Bible verse
        response = @provider.lookup(citation, version)
        # Create a string of the passage (for printing purposes)
        @passage = response.to_s
        # Split the passage into an array of every word
        @passage_words = @passage.split(' ')
    end

    # Return the string of the passage
    def return_passage
        @passage # String of the passage
    end

    # Return the string array of every word in the passage
    def return_passage_words
        @passage_words # Array of every word in the passage
    end
end