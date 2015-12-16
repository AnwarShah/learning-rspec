describe 'String' do

  describe "#titleize" do

    it "capitalizes each word in a string" do
      expect("this is an example".titleize).to eq("This Is An Example")
    end
    
    it "works with single-word strings" do
      expect("this".titleize).to eq("This")
    end
    
    it "capitalizes all uppercase strings" do
      expect("THIS IS A STRING".titleize).to eq("This Is A String")
    end
    
    it "capitalizes mixed-case strings" do
      expect("tHis Is a sTring".titleize).to eq("This Is A String")
    end
    
  end
  
  describe '#blank?' do

    it "returns true if string is empty" do
      expect(''.blank?).to be true
    end

    it "returns true if string contains only spaces" do
      expect(' '.blank?).to be true
    end

    it "returns true if string contains only tabs" do
      # Get a tab using a double-quoted string with \t
      # example: "\t\t\t"      
      expect("\t\t\t".blank?).to be true
    end


    it "returns true if string contains only spaces and tabs" do
      expect(" \t".blank?).to be true
    end
    
    it "returns false if string contains a letter" do
      expect("a \t".blank?).to be false
    end

    it "returns false if string contains a number" do
      expect("2".blank?).to be false
    end
    
  end
  
end
