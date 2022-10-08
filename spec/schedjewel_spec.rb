# frozen_string_literal: true

RSpec.describe Schedjewel do
  describe '#logger' do
    subject(:logger) { Schedjewel.logger }

    it 'is a Logger' do
      expect(logger).to be_a(Logger)
    end
  end
end
