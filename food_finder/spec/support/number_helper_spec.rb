# encoding: UTF-8

describe 'NumberHelper' do

  include NumberHelper

  describe '#number_to_currency' do

    context 'using default values' do

      it "correctly formats an integer" do
        output1 = number_to_currency(30)
        output2 = number_to_currency(300)
        output3 = number_to_currency(4000)
        output4 = number_to_currency(99_99_999)
        output5 = number_to_currency(-1444)

        expect(output1).to eq('$30.00')
        expect(output2).to eq('$300.00')
        expect(output3).to eq('$4,000.00')
        expect(output4).to eq('$9,999,999.00')
        expect(output5).to eq('$-1,444.00')
      end

      it "correctly formats a float" do
        output1 = number_to_currency(30.3)
        output2 = number_to_currency(300.33)
        output3 = number_to_currency(4000.333)
        output4 = number_to_currency(99_99_999.333333)
        output5 = number_to_currency(-1444.90000)

        expect(output1).to eq('$30.30')
        expect(output2).to eq('$300.30')
        expect(output3).to eq('$4,000.30')
        expect(output4).to eq('$9,999,999.30')
        expect(output5).to eq('$-1,444.90')
      end

      it "correctly formats a string" do
        output1 = number_to_currency('30')
        output2 = number_to_currency('300.20')
        output3 = number_to_currency('4000.3')
        output4 = number_to_currency('9999999.33')
        output5 = number_to_currency('-1444.50')

        expect(output1).to eq('$30.00')
        expect(output2).to eq('$300.20')
        expect(output3).to eq('$4,000.30')
        expect(output4).to eq('$9,999,999.30')
        expect(output5).to eq('$-1,444.50')
      end

      it "uses delimiters for very large numbers" do
        output1 = number_to_currency(500500500800900)
        output3 = number_to_currency('4000.3')
        output4 = number_to_currency('9999999.33')
        output5 = number_to_currency('-1444.50')

        expect(output1).to eq('$500,500,500,800,900.00')
        expect(output3).to eq('$4,000.30')
        expect(output4).to eq('$9,999,999.30')
        expect(output5).to eq('$-1,444.50')
        expect(output3).to match(/,/)
        expect(output1).to include(',')
      end

      it "does not have delimiters for small numbers" do
        output1 = number_to_currency(30.3)
        output2 = number_to_currency(300.33)
        output3 = number_to_currency(400.333)

        expect(output1).not_to include(',')
        expect(output3).not_to include(',')
        expect(output3).not_to match(/,/)
      end

    end

    context 'using custom options' do

      it 'allows changing the :unit' do
        output1 = number_to_currency(30, unit: 'Tk.')

        expect(output1).to eq('Tk.30.00')
      end

      it 'allows changing the :precision' do
        output1 = number_to_currency(400, precision: 3)

        expect(output1).to eq('$400.000')
      end

      it 'omits the separator if :precision is 0' do
        output1 = number_to_currency(4000, precision: 0)
        output2 = number_to_currency(40, precision: 0)

        expect(output1).to eq('$4,000')
        expect(output2).to eq('$40')
      end

      it 'allows changing the :delimiter' do
        output1 = number_to_currency(4000, delimiter: '.')
        output2 = number_to_currency(4000, delimiter: '-')

        expect(output1).to eq('$4.000.00')
        expect(output2).to eq('$4-000.00')
      end

      it 'allows changing the :separator' do
        output1 = number_to_currency(4000, separator: ',')
        output2 = number_to_currency(4000, separator: '-')

        expect(output1).to eq('$4,000,00')
        expect(output2).to eq('$4,000-00')
      end

      it 'correctly formats using multiple options' do
        output1 = number_to_currency(4000, unit: 'Tk.', separator: ',', delimiter: '.')

        expect(output1).to eq('Tk.4.000,00')
      end

    end

  end

end
