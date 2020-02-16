# frozen_string_literal: true
# rubocop:disable AllCops

RSpec.describe Regexp,
               :usecases,
               :jsonX,
               :debug,
               :markdownX,
               :markdown_prettier,
               :markdown_open,
               markdown_file: 'docs/regex/01-literal.md',
               document_title: 'Regex literal matching',
               document_description: 'Match against simple text literals' do
  describe 'initialization' do
    # subject { described_class.new(expression) }
    # let(:expression) { 'abc' }

    usecase '- Regexp.new',
            usage: "#{described_class.name}.new('abc')",
            usage_description: 'Creates a regular expression that can be used for matching and scanning' do
      ruby 'returns a regular expression' do
        regex = Regexp.new('abc')

        expect(regex).to eq(/abc/)
      end
    end

    usecase '- /abc/',
            usage: '/abc/',
            usage_description: 'Syntactic sugar for creating a regular expression that can be used for matching and scanning' do
      ruby 'returns a regular expression' do
        regex = /abc/

        expect(regex).to eq(/abc/)
      end

      ruby 'forward slashes must be escaped' do
        regex = /\/home\/user/

        expect(regex).to eq(Regexp.new('/home/user'))
      end
    end

    # backslash leans backwards ( \ ), while a forward slash leans forward ( / )
    usecase '- %r{abc}',
            usage: '%r{abc}',
            usage_description: 'Another way of creating a regular expressions, this technique is forward slash friendly',
            more_add_this_somewhere: '`%r{}` is equivalent to the `/.../` notation, but allows you to have `" / "` in your regexp without having to escape them',
            more_link: 'https://stackoverflow.com/a/12384762/473923',
            see_other: 'x modifer for good example' do
      ruby 'returns a regular expression' do
        regex = /abc/

        expect(regex).to eq(/abc/)
      end

      ruby 'forward slashes do not need to be escaped' do
        regex = %r{/home/user}

        expect(regex).to eq(/\/home\/user/)
      end
    end

    usecase '- %r bracketed variations',
            usage: '%r{abc} or %r(abc) or ...',
            usage_description: 'Ruby supports many bracketed variations of the %r operation',
            more_link: 'https://stackoverflow.com/a/12384762/473923',
            see_other: 'x options modifer for good example' do
      ruby 'returns a regular expression' do
        regex = /a\/b/

        expect(regex).to eq(/a\/b/)
          .and(eq(%r{a/b}))
          .and(eq(%r(a/b)))
          .and(eq(%r[a/b]))
          .and(eq(%r!a/b!))
          .and(eq(%r'a/b'))
          .and(eq(%r"a/b"))
      end
    end
  end

  describe 'match' do
    usecase 'simple literal expression',
            usage: '"my abc".match(/abc/)',
            usage_description: 'Creates a simple literal RegEx that can be used for matching' do
      
      ruby 'finds a simple literal expression' do
        text = 'my abc'
        regex = /abc/
        match = text.match(regex)
        
        expect(match).not_to be_nil
        expect(match.to_s).to eq('abc')
        expect(text.index(regex)).to eq(3)
      end
    end

    usecase 'multiple simple literal expressions',
            usage: '"abc and abc or abc".match(/abc/)',
            usage_description: 'Matches against a literal expression multiple times' do

      # ---------------------------------------------
      #           1         2         3         4
      # 012345678901234567890123456789012345678901
      # the quick brown fox, outfoxed the lazy dog
      #                 1       2
      #                 6       4
      # ---------------------------------------------

      let(:rex) { /fox/ }
      let(:text) { 'the quick brown fox, outfoxed the lazy dog' }
      
      ruby 'find first occurance' do
        expect(text.match(rex)).not_to be_nil
        expect(text.match(rex).to_s).to eq('fox')
        expect(text.index(rex)).to eq(16)
      end

      ruby 'Find second occurance',
           summary: 'The starting index should be after the last character of the previous match' do

        starting_index = (16 + 'fox'.length)

        match = text.match(rex, starting_index)

        expect(match).not_to be_nil
        expect(match.to_s).to eq('fox')
        expect(text.index(rex, starting_index)).to eq(24)
      end

      ruby 'Third match should not be found' do
        starting_index = (24 + 'fox'.length)

        match = text.match(rex, starting_index)

        expect(match).to be_nil
        expect(text.index(rex, starting_index)).to be_nil
      end
    end

    usecase 'multiple simple literal as substring',
            usage: '"aaaaaa".match(/aa/)',
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

      ruby 'find first occurance' do
        expect(text.index(rex)).to eq(2)
      end

      ruby 'Find second occurance',
           summary: 'The starting index should be index from 1st occurance plus 3 `"aaa".length`' do
        expect(text.index(rex, 2+3)).to eq(5)
      end

      ruby 'Find third occurance',
           summary: 'The starting index should be index from 2nd occurance plus 3 `"aaa".length`' do
        expect(text.index(rex, 5+3)).to eq(8)
      end

      ruby 'Find fourth occurance',
           summary: 'The starting index should be index from 3rd occurance plus 3 `"aaa".length`' do
        expect(text.index(rex, 8+3)).to eq(16)
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