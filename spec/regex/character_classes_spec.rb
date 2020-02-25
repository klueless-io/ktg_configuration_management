# frozen_string_literal: true
# rubocop:disable AllCops

# Resources:
# https://idiosyncratic-ruby.com/11-regular-extremism.html
# https://stackoverflow.com/questions/3512471/what-is-a-non-capturing-group-in-regular-expressions
# https://stackoverflow.com/questions/19486686/recursive-nested-matching-pairs-of-curly-braces-in-ruby-regex
# https://doc.lagout.org/programmation/Regular%20Expressions/Regular%20Expressions%20Cookbook_%20Detailed%20Solutions%20in%20Eight%20Programming%20Languages%20%282nd%20ed.%29%20%5BGoyvaerts%20%26%20Levithan%202012-09-06%5D.pdf
# https://www.princeton.edu/~mlovett/reference/Regular-Expressions.pdf
# https://github.com/stedolan/jq/wiki/Docs-for-Oniguruma-Regular-Expressions-(RE.txt)

RSpec.describe '',
               :usecases,
               :jsonX,
               :debugX,
               :markdownX,
               :markdown_prettier,
               :markdown_openX,
               markdown_file: 'docs/regex/01-character-class.md',
               document_title: 'Regex character class matching',
               document_description: 'Match against specific characters' do

  let(:scan) { text.scan rex }

  usecase "Character classes",
          usage: "'text'.match /[abc]/",
          usage_description: 'Match a string using known characters' do

    ruby 'match the first vowel' do
      alphabet = 'abcdefghijklmnopqrstuvwxyz'
      rex = /[aeiouy]/

      expect(rex =~ alphabet).to be_truthy
      expect(rex =~ alphabet).to eq(0)
    end

    ruby 'scan for all vowels' do
      alphabet = 'abcdefghijklmnopqrstuvwxyz'
      rex = /[aeiouy]/

      matches = alphabet.scan rex

      expect(matches.to_a).to eq(['a', 'e', 'i', 'o', 'u', 'y'])
    end

    ruby 'match any characters in the set' do
      # the 2nd character is a or b
      rex = /a[ab]c/
      
      expect(rex =~ 'aac').to be_truthy
      expect(rex =~ 'abc').to be_truthy

      # 
      expect(rex =~ 'acc').to be_falsey
    end
  end

  usecase "Character ranges",
      usage: "'text'.match /[a-e]]/",
      usage_description: 'Match all characters that match a range of characters' do

    ruby 'match the first vowel' do
      alphabet = 'abcdefghijklmnopqrstuvwxyz'
      rex = /[l-p]/

      expect(rex =~ alphabet).to be_truthy
      expect(rex =~ alphabet).to eq(11)
    end

    ruby 'scan all characters in a range' do
      alphabet = 'abcdefghijklmnopqrstuvwxyz'
      rex = /[a-e]/
      
      matches = alphabet.scan rex

      expect(matches.to_a).to eq(['a', 'b', 'c', 'd', 'e'])
    end

    ruby 'match characters from either set: 1-9 or a-e' do
      rex = /[1-9a-e]/
      
      # Match
      expect(rex =~ '111').to be_truthy
      expect(rex =~ 'aaa').to be_truthy

      # No match
      expect(rex =~ 'AAA').to be_falsey
      expect(rex =~ 'zzz').to be_falsey
    end

    ruby 'match characters that are NOT in the set: 1-9 or a-e' do
      # If the first character of a character 
      # class is a caret (^) the class is inverted.
      # It matches any character except those named.
      rex = /[^1-9a-e]/
      
      # No match
      expect(rex =~ '111').to be_falsey
      expect(rex =~ 'aaa').to be_falsey

      # Match
      expect(rex =~ 'AAA').to be_truthy
      expect(rex =~ 'zzz').to be_truthy
    end
  
  end

  usecase "Useful ranges and shorthand notations",
    usage_description: 'List of useful character ranges and sharthand notations that are handy to know' do

    ruby 'matches any letter from a to z (no caps)' do
      expect(/[a-z]/ =~ 'abcdef').to be_truthy
      expect(/[a-z]/ =~ 'ABCDEF').to be_falsey
    end

    ruby 'negated range: match any character that is NOT a to z' do
      rex = /[^a-z]/
      expect(rex =~ '12345').to be_truthy
      expect(rex =~ 'ABCDEF').to be_truthy
      expect(rex =~ '######').to be_truthy
      expect(rex =~ '      ').to be_truthy
      expect(rex =~ 'abcdef').to be_falsey
    end

    ruby 'matches any number from 0 to 9' do
      expect(/[0-9]/ =~ 'they had 5 chickens').to be_truthy
      expect(/[0-9]/ =~ 'they had no chickens').to be_falsey
    end

    ruby '\d will match any number from 0 to 9' do
      expect(/\d/ =~ 'they had 5 chickens').to be_truthy
      expect(/\d/ =~ 'they had no chickens').to be_falsey
    end

    ruby '\D negated form of \d is equivalent to [^0-9]' do
      expect(/\d/ =~ 'abcde').to be_falsey
      expect(/\d/ =~ '12345').to be_truthy
    end

    ruby '\w will match wordish concepts and is equivalent to [0-9a-zA-Z_]' do

      # The \w is useful for scanning course code 
      # and other types of symbolized text
      expect(/\w/ =~ 'my_variable1').to be_truthy
      expect(/\w/ =~ '------------').to be_falsey
    end

    ruby '\W negated form of \w and is equivalent to [^0-9a-zA-Z_]' do
      expect(/\W/ =~ 'my_variable1').to be_falsey
      expect(/\W/ =~ '------------').to be_truthy
    end

    ruby '\s will match white space' do
      space = ' '
      tab = "\t"
      newline = "\n"

      word = 'klueless.io'

      expect(/\s/ =~ space).to be_truthy
      expect(/\s/ =~ tab).to be_truthy
      expect(/\s/ =~ newline).to be_truthy
      expect(/\s/ =~ word).to be_falsey
    end

    ruby '\S negated form of \s' do
      space = ' '
      tab = "\t"
      newline = "\n"

      word = 'klueless.io'

      expect(/\S/ =~ space).to be_falsey
      expect(/\S/ =~ tab).to be_falsey
      expect(/\S/ =~ newline).to be_falsey
      expect(/\S/ =~ word).to be_truthy
    end
  end
end
