# frozen_string_literal: true

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
               :markdown,
               :markdown_prettier,
               :markdown_openX,
               markdown_file: 'docs/regex/00-usage.md',
               document_title: 'Regex usage patterns',
               document_description: 'Different ways of using the Regex class and the various methods plus other support classes' do

  describe 'initialization' do
    usecase '- Regexp.new',
            usage: "#{described_class}.new('abc')",
            usage_description: 'Creates a regular expression that can be used for matching and scanning' do
      ruby 'creates a regular expression using Regex class' do
        regex = Regexp.new('abc')

        expect(regex).to eq(/abc/)
      end
    end

    usecase '- /abc/',
            usage: '/abc/',
            usage_description: 'Syntactic sugar for creating a regular expression that can be used for matching and scanning' do
      ruby 'creates a regular expression (syntactic sugar)' do
        regex = /abc/

        expect(regex).to eq(/abc/)
      end

      ruby 'forward slashes must be escaped' do
        regex = /\/home\/user/

        expect(regex).to eq(Regexp.new('/home/user'))
      end
    end

    usecase '- %r{abc}',
          usage: '%r{abc}',
          usage_description: 'Another way of creating a regular expressions, this technique is forward slash friendly',
          more_link: 'https://stackoverflow.com/a/12384762/473923',
          see_other: 'x modifer for good example' do
      ruby 'creates a regular expression (more syntactic sugar)' do
        regex = %r{abc}

        expect(regex).to eq(/abc/)
      end

      ruby 'forward slashes do not need to be escaped' do
        expect(%r{/home/user/development/source_file.js}).to \
                eq(/\/home\/user\/development\/source_file.js/)
      end
    end
  
    usecase '- %r bracketed variations',
        usage: '%r{abc} or %r(abc) or ...',
        usage_description: 'Ruby supports many bracketed variations of the %r operation' do
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

  describe 'match()' do
    usecase "match method",
            usage: "/my expression/.match('my content')",
            usage_description: 'Matches regular expression against a string. It returns the MatchData object if found or nil when not found' do

      context 'match text' do
        ruby 'klueless is found in content' do
          rex = /klueless/
          text = 'rapid microservices using klueless.io'

          match = text.match(rex)
          
          expect(match).not_to be_nil
          expect(match.to_s).to eq('klueless')
          expect(match.offset(0)).to eq([26,34])
          expect(match.begin(0)).to eq(26)
          expect(match.end(0)).to eq(34)
        end
      end

      context 'does not match text' do
        ruby 'appydave is not found content' do
          rex = /appydave/
          text = 'rapid microservices using klueless.io'

          expect(rex.match(text)).to be_nil
        end
      end
    end
  end

  usecase "=~ match operator",
          usage: "/my expression/ =~ 'my content'",
          usage_description: 'Matches regular expression against a string, it returns the index if found or nil when not found' do


    context 'match text' do
      ruby 'klueless is found in content' do
        rex = /klueless/
        text = 'rapid microservices using klueless.io'

        expect(rex =~ text).to be_truthy
        expect(rex =~ text).to eq(26)
      end

      ruby 'the order of regex and string does not mater' do
        rex = /klueless/
        text = 'rapid microservices using klueless.io'

        expect(rex =~ text).to eq(26)
        expect(text =~ rex).to eq(26)
      end
    end

    context 'does not match text' do
      ruby 'appydave is not found content' do
        rex = /appydave/
        text = 'rapid microservices using klueless.io'

        expect(rex =~ text).to be_falsy
        expect(rex =~ text).to be_nil
      end
    end
  end

  usecase "dynamic placeholders in regular expressions",
          usage: "/#\{placeholder}/.match('my content')",
          usage_description: 'Use dynamic placeholders to inject content into yoru regular' do

    context 'match text' do
      ruby 'klueless is found in content' do
        checkout = 'klueless'
        rex = /#{checkout}.io/
        text = 'your should checkout klueless.io'

        expect(rex.match(text)).to_not be_nil
        expect(rex.match(text).begin(0)).to eq(21)
      end
    end
  end
end
