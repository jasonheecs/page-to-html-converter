require_relative '../spec_helper'

describe 'POST /result' do
  before do
    post('/result', params)
  end

  context 'valid url' do
    let(:params) do
      { url: 'http://www.nokogiri.org/tutorials/installing_nokogiri.html' }
    end

    it 'is successful' do
      expect(last_response.ok?).to be true
      attrs_to_not_strip = Sinatra::HTMLConverter::Helpers::URLParser.attrs_to_not_strip
      expect(last_response.body).not_to include(*attrs_to_not_strip)
    end
  end

  context 'no url' do
    let(:params) {}

    it 'returns 422' do
      expect(last_response.ok?).to be false
      expect(last_response.status).to eq 422
    end
  end

  context 'invalid url' do
    let(:params) { { url: 'this.is.an.invalid.url' } }

    it 'returns 400' do
      expect(last_response.ok?).to be false
      expect(last_response.status).to eq 400
    end
  end
end