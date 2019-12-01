# memory_verse_bot

A program to randomly remove words from a passage to help memorize Bible verses

## Table of Contents

1. Requirements  
2. Recommended Modules  
3. Installation  
4. Configuration  
5. Known Issues

## 1. Requirements

Ruby: <https://www.ruby-lang.org/en/downloads/>

## 2. Recommended Modules

Visual Studio Code: <https://code.visualstudio.com/>  
Ruby Language Support for VS Code: <https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby>  
Ruby Solargraph: <https://marketplace.visualstudio.com/items?itemName=castwide.solargraph>  
Code Runner: <https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner>

## 3. Installation

First install Ruby. Then download and extract the .zip file from this GitHub repository.

## 4. Configuration

To run this program you'll have to use the CMD with Ruby that comes with Ruby's installation.  

1. Search for 'Start Command Prompt with Ruby'.  
2. Open 'Start Command Prompt with Ruby'.  
3. Go to the directory of the memory_verse_bot.rb file.  
4. Type: 'ruby memory_verse_bot.rb'.  

## 5. Known Issues

### NOT SOLVED

### SOLVED

1. The program sometimes fails when checking the user's input for a blank; this leads to the grading to fail and the blank-filling to fail as well. SOLUTION: typo in code where the punctuation is supposed to be removed from the answer
2. Quotation marks are not being added back into the blanks, but all other marks are. SOLUTION: Use unicode characters \u201c and \u201d instead of \"
