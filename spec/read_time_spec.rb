describe 'ReadTime' do
  let(:words_1)   { 'word ' }
  let(:words_250) { 'word ' * 250 }
  let(:words_251) { 'word ' * 251 }
  let(:words_275) { 'word ' * 275 }
  let(:words_276) { 'word ' * 276 }
  let(:words_275_hyphen) { 'word-word ' * 275 }

  before(:each) do
    ReadTime.reset_config
  end

  describe 'Default configuration' do
    it 'uses default format' do
      expect(ReadTime.config.format).to eql(:default)
    end

    it 'uses default reading_speed' do
      expect(ReadTime.config.reading_speed).to eql(275)
    end
  end

  describe 'Change Configuration' do
    it 'uses new configuration when provided' do
      ReadTime.configure do |config|
        config.reading_speed = 250
        config.format        = :long
      end

      expect(ReadTime.config.format).to eql(:long)
      expect(ReadTime.config.reading_speed).to eql(250)
    end
  end

  describe '#readtime' do
    it 'with default configuration' do
      expect(ReadTime.config.reading_speed).to eql(275)
      expect(words_1.readtime).to   eql('1 minute read')
      expect(words_275.readtime).to eql('1 minute read')
      expect(words_276.readtime).to eql('2 minute read')
    end

    it 'with changed configuration' do
      ReadTime.configure do |config|
        config.reading_speed = 250
        config.format        = :long
      end

      expect(words_250.readtime).to eql('1 minute read')
      expect(words_251.readtime).to eql('1 minute 1 second read')
    end

    it 'with configuration' do
      expect(ReadTime.config.reading_speed).to eql(275)
      expect(words_275.readtime).to eql('1 minute read')
      expect(words_276.readtime).to eql('2 minute read')
      expect(words_276.readtime(reading_speed: 276)).to eql('1 minute read')
      expect(words_276.readtime(format: :long)).to eql('1 minute 1 second read')
      expect(words_276.readtime(reading_speed: 276, format: :long)).to eql('1 minute read')

      expect(words_275_hyphen.readtime).to eql('1 minute read')
    end
  end
end
