# Class for creating verses
class VerseMaker
    # Instance variables
    @provider
    @passage_words
    @passage

    # Initialize VerseMaker
    def initialize()
        # Initializing 'scripture_lookup' to get Bible verses
        @provider = ScriptureLookup.new
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
        # String of the passage
        @passage
    end

    # Return the string array of every word in the passage
    def return_passage_words
        # Array of every word in the passage
        @passage_words
    end
end