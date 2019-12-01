require_relative '../lib/memory_verse_bot/file_maker.rb'

file_maker = FileMaker.new

print 'File name: '
file_name = gets.chomp.to_s

file_maker.make_file(file_name)

print 'Info: '
info = gets.chomp.to_s

file_maker.write(info)