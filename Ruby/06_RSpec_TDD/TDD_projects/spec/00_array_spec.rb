require "00_array"

describe Array do

    describe "#my_uniq" do
        let(:array) { [1, 2, 1, 3, 3] }
        let(:uniq_array) { array.my_uniq }
        
        it "removes duplicates from an array" do
            count = Hash.new(0)
            uniq_array.each do |el|
                count[el] += 1
                expect(count[el]).to eq(1)
            end
        end

        it "only contains items from original array" do
            uniq_array.each do |el|
                expect(array).to include(el)
            end
        end

        it "does not modify original array" do
            expect{ array.my_uniq }.to_not change{ array }
        end
    
    end

    describe "#two_sum" do
        let(:array) { [-1, 0, 2, -2, 1] }
        let(:single_zero) { [1, 0, 2] }
        let(:two_zeros) { [1, 0, 0] }

        it "finds zero-sum pair" do
            expect(array.two_sum).to eq([[0, 4], [2, 3]])
        end

        it "allows smaller first elements come first" do 
            sorted = array.two_sum.sort
            expect(array.two_sum).to eq(sorted)
        end

        it "is not confused by a single zero" do
            expect(single_zero.two_sum).to eq([])
        end

        it "handles two zeros" do
            expect(two_zeros.two_sum).to eq([[1, 2]])
        end
    end

    describe "#my_transpose" do 
        let(:array) { [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ]}

        it "transpose the array" do 
            expect(array.my_transpose).to eq([[0, 3, 6],
                                            [1, 4, 7],
                                            [2, 5, 8]])
        end
    end

    describe "#pick_stocks" do 
        
        it "pick pairs of days" do
            expect([8, 7, 3, 9, 8].pick_stocks).to eq([2, 3])
        end

        it "finds a better pair after an inferior pair" do
            expect([3, 2, 5, 0, 6].pick_stocks).to eq([3, 4])
        end

        it "never buys stocks in a crash" do
            expect([5, 4, 3, 2, 1].pick_stocks).to be_nil
        end
    end

end