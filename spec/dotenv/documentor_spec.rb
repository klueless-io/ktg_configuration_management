# frozen_string_literal: true

require 'dotenv'

RSpec.describe Dotenv, :usecases, :printX do
  describe 'load' do
    subject { described_class.load() }

    usecase 'Default title',
            usage: "#{described_class.name}.load" do
      fit 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' do
        puts @document
      end
    end

    usecase 'Overwrite the title',
            usage: "#{described_class.name}.load",
            title: 'Default.load will load your application configuration from your `.env` file found in the project root:' do
      fit 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' do
        puts @document
      end
    end
  end
end
