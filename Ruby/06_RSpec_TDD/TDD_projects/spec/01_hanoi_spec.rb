require "01_hanoi"

describe TowersOfHanoiGame do
    subject(:towers) { TowersOfHanoiGame.new }

    describe "#render" do
        it "pretty print stacks" do
            expect(towers.render).to eq("Tower 0: 3 2 1\nTower 1: \nTower 2: \n")
        end
    end

    describe "#move" do
        it "allows moving to a blank space" do
            expect{ towers.move(0, 1) }.not_to raise_error
        end
        
        it "allows moving onto a larger disk" do
            towers.move(0, 2)
            towers.move(0, 1)
            expect{ towers.move(2, 1) }.not_to raise_error
        end

        it "does not allow moving from an empty stack" do
            expect{ towers.move(1, 2) }.to raise_error("stack is empty")
        end

        it "does not allow moving onto a smaller disk" do
            towers.move(0, 1)
            expect{ towers.move(0, 1) }.to raise_error("moving onto a smaller disk")
        end
    end
    
    describe "#won?" do
        
        # expect(actual).to be_xxx => passes if actual.xxx?
        # expect(towers).to be_won => passes if towers.won?
        
        it "is not won at the start" do 
            expect(towers).not_to be_won
        end

        it "wins with Tower 1" do 
            towers.move(0, 1)
            towers.move(0, 2)
            towers.move(1, 2)
            towers.move(0, 1)
            towers.move(2, 0)
            towers.move(2, 1)
            towers.move(0, 1)
            expect(towers).to be_won
        end

        it "wins with Tower 2" do 
            towers.move(0, 2)
            towers.move(0, 1)
            towers.move(2, 1)
            towers.move(0, 2)
            towers.move(1, 0)
            towers.move(1, 2)
            towers.move(0, 2)
            expect(towers).to be_won
        end
    end
end
