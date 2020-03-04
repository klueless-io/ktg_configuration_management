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
               :markdownX,
               :markdown_prettier,
               :markdown_openX,
               markdown_file: 'docs/regex/50-advanced-find-strings.md',
               document_title: 'Find strings in content',
               document_description: 'Look for strings that are inside single or double quotes' do

  let(:scan) { text.scan rex }

  usecase "Match text in either single or double quote",
          usage: "'text'.scan /[abcA-C]]/",
          usage_description: 'Match all characters that match using known characters and ranges' do

    v_rex = /
      (?<quote_left>[\'"])     # capture left quote

      (?<text>(?:
        (?!\k<quote_left>).    # not a quote
        |                      # or
        \k<quote_left>         # escaped one
      )*                       #  

      [^\\\\]?)

      (?<quote_right>\k<quote_left>)    # match left quote and call it right quote
    /x

    let(:rex) { v_rex }

    # Move single and doulbe quotes int

    context 'match single quote text' do

      v_text = %Q{

        An sentence surrounded by single quotes
        
        'Don\'t you think \"Karin\" is awesome.' should be captured

        plus, any sentence captured by double quotes
      
        "Don't you think \"Karin\" is still awesome." 
        
        should also be captured out of this document
      }

      let(:text) { v_text }
      
      ruby 'match sentences surounded by single or double quotes',
          code: "text = '#{v_text}'\nrex = /#{v_rex.source}/" do

        scan = text.scan rex

        expect(scan[0][1].to_s).to eq('Don\'t you think "Karin" is awesome.')
        expect(scan[1][1].to_s).to eq('Don\'t you think "Karin" is still awesome.')
      end

      it { expect(scan[0][1].to_s).to eq('Don\'t you think "Karin" is awesome.') }
      it { expect(scan[1][1].to_s).to eq('Don\'t you think "Karin" is still awesome.')}
    end

    context 'match double quote text' do

      v_text = %Q{


        The following sentence: "Don't you think \"Karin\" is awesome." is what we want to capture
      
      
      }
      let(:text) { v_text }

      ruby 'match any lower case vowels',
          code: "text = '#{v_text}'\nrex = /#{v_rex.source}/" do
# "dou\"ble 'quote"

        match = text.match rex
        puts match.to_s
        puts match.inspect
        puts match[:text].to_s
        expect(match[:text].to_s).to eq('Don\'t you think "Karin" is awesome.')
      end
    end
  end
end
