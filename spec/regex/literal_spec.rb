# frozen_string_literal: true
# rubocop:disable AllCops

RSpec.describe Regexp,
               :usecases,
               :jsonX,
               :debugX,
               :markdownX,
               :markdown_prettier,
               :markdown_openX,
               markdown_file: 'docs/regex/01-literal.md',
               document_title: 'Regex literal matching',
               document_description: 'Match against simple text literals' do
  

  describe 'match' do
    # usecase 'simple literal expression',
    #         usage: '"my abc".match(/abc/)',
    #         usage_description: 'Creates a simple literal RegEx that can be used for matching' do
      
    #   ruby 'finds a simple literal expression',
    #     code: '<-- inject from block' do
    #     text = 'my abc'
    #     regex = /abc/
    #     match = text.match(regex)
        
    #     expect(match).not_to be_nil
    #     expect(match.to_s).to eq('abc')
    #     expect(match.offset(0)).to eq([3,6])
    #     expect(match.begin(0)).to eq(3)
    #     expect(match.end(0)).to eq(6)
    #   end
    # end

    usecase 'multiple occurances of simple expressions',
            usage: '"abc and abc or abc".match(/abc/)',
            usage_description: 'Matches against a literal expression multiple times',
            code: '<-- inject from block' do

      # ---------------------------------------------
      #           1         2         3         4
      # 012345678901234567890123456789012345678901
      # the quick brown foxfox, outfoxed the lazy dog
      #                 1  1       2
      #                 6  9       7
      # ---------------------------------------------

      let(:rex) { /fox/ }
      let(:text) { 'the quick brown foxfox, outfoxed the lazy dog' }
      
      ruby 'find first occurance' do
        match = text.match(rex)

        expect(match).not_to be_nil
        expect(match.to_s).to eq('fox')
        expect(match.offset(0)).to eq([16,19])
      end

      ruby 'Find second occurance',
           summary: 'The starting index should be after the last character of the previous match',
           code: '<-- inject from block' do

        start_index = 19

        match = text.match(rex, start_index)

        expect(match).not_to be_nil
        expect(match.to_s).to eq('fox')
        expect(match.offset(0)).to eq([19, 22])
      end

      ruby 'Third match should not be found' do
        start_index = 22

        match = text.match(rex, start_index)

        expect(match).not_to be_nil
        expect(match.to_s).to eq('fox')
        expect(match.offset(0)).to eq([27, 30])
      end
    end

    usecase 'find simple literal that occurs multiple times in succession',
            usage: '"aaaaaa".index(/aaa/)',
            usage_description: 'Matches short literal expressions against longer content' do

      let(:rex) { /aaa/ }
      let(:text) { 'xxaaaaaaaaaxxaa aaa' }

      # -------------------
      #           1        
      # 0123456789012345678
      # xxaaaaaaaaaxxaa aaa
      #                 1 
      #   2  5  8       6
      # -------------------

      ruby 'find first occurance',
        code: '<-- inject from block' do

        match = text.match(rex)

        expect(match).not_to be_nil
        expect(match.to_s).to eq('aaa')
        expect(match.offset(0)).to eq([2, 5])
      end

      ruby 'find second occurance',
           summary: 'The starting index should be index from 1st occurance plus 3 `"aaa".length`',
           code: '<-- inject from block' do

        start_index = 5

        match = text.match(rex, start_index)

        expect(match).not_to be_nil
        expect(match.to_s).to eq('aaa')
        expect(match.offset(0)).to eq([5, 8])
      end

      ruby 'find third occurance',
           summary: 'The starting index should be index from 2nd occurance plus 3 `"aaa".length`',
        code: '<-- inject from block' do

        start_index = 8

        match = text.match(rex, start_index)

        expect(match).not_to be_nil
        expect(match.to_s).to eq('aaa')
        expect(match.offset(0)).to eq([8, 11])
      end

      ruby 'Find fourth occurance',
           summary: 'The starting index should be index from 3rd occurance plus 3 `"aaa".length`',
        code: '<-- inject from block' do

        start_index = 11

        match = text.match(rex, start_index)

        expect(match).not_to be_nil
        expect(match.to_s).to eq('aaa')
        expect(match.offset(0)).to eq([16, 19])
      end
    end
  end
end

# Regex Options
# regexp = %r{
#   start         # some text
#   \s            # white space char
#   (group)       # first group
#   (?:alt1|alt2) # some alternation
#   end
# }x
# rubocop:enable AllCops