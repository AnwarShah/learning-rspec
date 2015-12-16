require 'restaurant'

describe Restaurant do

  let(:test_file) { 'spec/fixtures/restaurants_test.txt' }
  let(:crescent) { Restaurant.new(:name => 'Crescent', :cuisine => 'paleo', :price => '321') }
  
  describe 'attributes' do
    
    # use implicitly defined subject    
    # subject {Restaurant.new}
    
    it "allow reading and writing for :name" do
      subject.name = 'Test'
      expect(subject.name).to eq 'Test'  
    end

    it "allow reading and writing for :cuisine" do
      subject.name = "Honda"
      
      expect(subject.name).to eq 'Honda'
    end

    it "allow reading and writing for :price" do
      subject.price = 5000
      
      expect(subject.price).to eq 5000
    end
    
  end
  
  describe '.load_file' do

    it 'does not set @@file if filepath is nil' do
      no_output { Restaurant.load_file(nil) }
      expect(Restaurant.file).to be_nil
    end
    
    it 'sets @@file if filepath is usable' do
      no_output { Restaurant.load_file(test_file) }
      expect(Restaurant.file).not_to be_nil
      expect(Restaurant.file.class).to be(RestaurantFile)
      expect(Restaurant.file).to be_usable
    end

    it 'outputs a message if filepath is not usable' do
      expect do
        Restaurant.load_file(nil)
      end.to output(/not usable/).to_stdout
    end
    
    it 'does not output a message if filepath is usable' do
      expect do
        Restaurant.load_file(test_file)
      end.not_to output.to_stdout
    end
    
  end
  
  describe '.all' do
    
    it 'returns array of restaurant objects from @@file' do
      Restaurant.load_file(test_file)
      restaurants = Restaurant.all
      expect(restaurants.class).to eq(Array)
      expect(restaurants.length).to eq(6)
      expect(restaurants.first.class).to eq(Restaurant)
    end

    it 'returns an empty array when @@file is nil' do
      no_output { Restaurant.load_file(nil) }
      restaurants = Restaurant.all
      expect(restaurants).to eq([])
    end
    
  end
  
  describe '#initialize' do

    context 'with no options' do
      # subject would return the same thing
      let(:no_options) { Restaurant.new }

      it 'sets a default of "" for :name' do
        expect(no_options.name).to eq ""
      end

      it 'sets a default of "unknown" for :cuisine' do
        expect(no_options.cuisine).to eq "unknown"
      end

      it 'does not set a default for :price' do
        expect(no_options.price).to be_nil
      end
    end
    
    context 'with custom options' do
      
      it 'allows setting the :name' do
        expect(crescent.name).to eq "Crescent"
      end

      it 'allows setting the :cuisine' do
        expect(crescent.cuisine).to eq "paleo"
      end
      
      it 'allows setting the :price' do
        expect(crescent.price).to eq '321'
      end
      
    end

  end
  
  describe '#save' do
    
    it 'returns false if @@file is nil' do
      # Don't load a file here
      expect(Restaurant.file).to be_nil

      expect(crescent.save).to be false
    end
    
    it 'returns false if not valid' do
      # ensure not invalid because of file load
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil

      expect(subject.save).to be false
    end
    
    it 'calls append on @@file if valid' do
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil
      
      # spying for :append on Resturant.file i.e @@file
      allow(Restaurant.file).to receive(:append).with(crescent)
      
      # call save on valid object
      crescent.save
      
      # expect the call is made
      expect(Restaurant.file).to have_received(:append).with(crescent)
    end
    
  end
  
  describe '#valid?' do
    
    # a valid subject
    subject {Restaurant.new(
              name: 'Pizzahut',
              cuisine: 'Bangladesh',
              price: 123)}
    
    before(:example) do
      expect(subject.valid?).to be true
    end
    
    it 'returns false if name is nil' do
      # set name nil
      subject.name = nil
      
      # expect false
      expect(subject.valid?).to be false
    end

    it 'returns false if name is blank' do
      # set name to blank on valid subject
      subject.name = ''
      
      # expect false
      expect(subject.valid?).to be false
    end

    it 'returns false if cuisine is nil' do
      # set cuisine nil
      subject.cuisine = nil
      
      # expect false
      expect(subject.valid?).to be false
    end

    it 'returns false if cuisine is blank' do
      # set cuisine to blank on valid subject
      subject.cuisine = ''
      
      # expect false
      expect(subject.valid?).to be false
    end
    
    it 'returns false if price is nil' do
      # set price to nil on valid subject
      subject.price = nil
      
      # expect false
      expect(subject.valid?).to be false
    end

    it 'returns false if price is 0' do
      # set price to 0 on valid subject
      subject.price = 0
      
      # expect false
      expect(subject.valid?).to be false
    end
    
    it 'returns false if price is negative' do
      # set price to negative value on valid subject
      subject.price = -60
      
      # expect false
      expect(subject.valid?).to be false
    end

    it 'returns true if name, cuisine, price are present' do
      restaurant = Restaurant.new
      restaurant.name = "Bracket"
      restaurant.cuisine = "Bangla"
      restaurant.price = 123
      
      expect(restaurant.valid?).to be true
    end
    
  end

end
