# Class to create a file of an input
class FileMaker
    # Instance variables
    @dir       # The directory for the files to be saved (data folder by default)
    @file_type # The type fo the file (txt by default)
    @file      # The actual file to edit

    # Initialize FileMaker
    def initialize(dir = '../data/', file_type = 'txt')
        @dir       = dir       # Save the directory
        @file_type = file_type # Save the type of the file
    end

    # Create a new file with the above information and file name
    def make_file(file_name)
        @file = File.new("#{@dir}#{file_name}.#{@file_type}", 'w') # Create a new file for writing
    end

    # Write the information in the file
    def write(info)
        @file.puts(info) # Put the information in the file'
    end
end