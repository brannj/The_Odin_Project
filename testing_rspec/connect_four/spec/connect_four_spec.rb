require 'connect_four'

describe "Game" do
  let(:game) { Game.new }

  context "when a new game is called" do
    it "is an instance of Game" do
      expect(game).to be_an_instance_of Game
    end
  end

  describe "#play" do
    
  end
end
