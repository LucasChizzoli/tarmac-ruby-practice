require './utils/book_validation'

RSpec.describe 'Book Validation' do

  let(:isbn) { '1230091823471' }
  let(:title) { 'Book Title' }
  let(:publisher) { 'Book Publisher' }
  let(:website) { 'Book Website' }
  let(:date) { '02/10/2018' }

  describe 'Book validation' do

    it 'should return true if date is valid' do
      expect(BookValidation.validate_date(date)).to eq true
    end

    it 'should return nil if date is not valid' do 
      expect(BookValidation.validate_date('')).to eq nil
    end

    it 'should return true if isbn length is 13' do 
      expect(BookValidation.validate_ISBN(isbn)).to eq true
    end

    it 'should return false if isbn length is different than 13' do 
      expect(BookValidation.validate_ISBN('')).to eq false
    end

    it 'should return true if title is present' do 
      expect(BookValidation.validate_title(title)).to eq true
    end

    it 'should return false if title is not present' do 
      expect(BookValidation.validate_title('')).to eq false
    end

    it 'should return true if publisher is present' do 
      expect(BookValidation.validate_publisher(publisher)).to eq true
    end

    it 'should return false if publisher is not present' do 
      expect(BookValidation.validate_publisher('')).to eq false
    end

    it 'should return true if website is present' do 
      expect(BookValidation.validate_website(website)).to eq true
    end

    it 'should return false if website is not present' do 
      expect(BookValidation.validate_website('')).to eq false
    end
  end
end