require 'chess'

describe "Chess" do
  let(:game) = { Chess.game }

  describe "ChessGame" do
    it "creates a new game" do
      expect(game).to be_an_instance_of(ChessGame)
    end
  end

  describe "Board" do
    it "creates a new board"

    it "is a board with "

    it "starts with white"

    it "asks for a move from white"

    it "changes to black"

    it "asks for a move from black"
  end
end
