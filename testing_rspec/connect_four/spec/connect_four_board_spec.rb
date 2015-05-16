require "connect_four_board.rb"

describe "Board" do
  let(:board) { Board.new }

  context "when board initializes" do
    it "makes a board object" do
      expect(board).to be_an_instance_of(Board)
    end

    it "creates an board with 6 rows" do
      expect(board.board.length).to eq(6)
    end

    it "creates an board with 7 columns" do
      board.board.each do |row|
        expect(row.length).to eq(7)
      end
    end
  end

  describe "#show" do
    it "shows a board without moves"
  end

  describe "#check_column?" do
    context "when a column" do
      it "is empty" do
        expect(board.check_column?(3)).to be_truthy
      end

      it "has one space" do
        0.upto(4) { |i| board.board[i][3] = " \u26aa" }
        expect(board.check_column?(3)).to be_truthy
      end

      it "is full" do
        board.board.each { |row| row[3] = " \u26aa" }
        expect(board.check_column?(3)).to be_falsey
      end
    end
  end

  describe "#store_move" do
    context "when a move is stored" do
      it "goes to the bottom of an empty column" do
        board.store_move(3, " \u26aa")
        expect(board.board[0][2]).to eq(" \u26aa")
      end

      it "goes to the next space in a non-empty column" do
        board.store_move(3, " \u26ab")
        board.store_move(3, " \u26aa")
        expect(board.board[1][2]).to eq(" \u26aa")
      end
    end
  end

  describe "#check_win?" do
    context "where four similar pieces are adjacent" do
      it "returns true for vertical alignment" do
        4.times { board.store_move(3, " \u26aa") }
        expect(board.check_win?).to be_truthy
      end

      it "returns true for horizontal alignment" do
        0.upto(4) { |i| board.store_move(i, " \u26aa") }
        expect(board.check_win?).to be_truthy
      end

      it "returns true for diagonal1 alignment" do
        5.times { board.store_move(1, " \u26ab") }
        board.store_move(1, " \u26aa")
        4.times { board.store_move(2, " \u26ab") }
        board.store_move(2, " \u26aa")
        3.times { board.store_move(3, " \u26ab") }
        board.store_move(3, " \u26aa")
        2.times { board.store_move(4, " \u26ab") }
        board.store_move(4, " \u26aa")
        expect(board.check_win?).to be_truthy
      end

      it "returns true for diagonal2 alignment" do
        board.store_move(1, " \u26ab")
        board.store_move(2, " \u26ab")
        board.store_move(2, " \u26aa")
        2.times { board.store_move(3, " \u26ab") }
        board.store_move(3, " \u26aa")
        3.times { board.store_move(4, " \u26ab") }
        board.store_move(4, " \u26aa")
        4.times { board.store_move(5, " \u26ab") }
        board.store_move(5, " \u26aa")
        expect(board.check_win?).to be_truthy
      end
    end

    context "where four similar pieces are not adjacent" do
      it "returns false for vertical alignment" do
        3.times { board.store_move(3, " \u26aa") }
        2.times { board.store_move(3, " \u26ab") }
        board.store_move(3, " \u26aa")
        expect(board.check_win?).to be_falsey
      end

      it "returns false for horizontal alignment" do
        0.upto(3) { |i| board.store_move(i, " \u26aa") }
        3.upto(6) { |i| board.store_move(i, " \u26ab") }
        6.upto(8) { |i| board.store_move(i, " \u26aa") }
        expect(board.check_win?).to be_falsey
      end

      it "returns false for diagonal1 alignment" do
        5.times { board.store_move(1, " \u26ab") }
        board.store_move(1, " \u26aa")
        4.times { board.store_move(2, " \u26ab") }
        board.store_move(2, " \u26aa")
        3.times { board.store_move(3, " \u26ab") }
        board.store_move(3, " \u26aa")
        3.times { board.store_move(4, " \u26ab") }
        2.times { board.store_move(5, " \u26aa") }
        expect(board.check_win?).to be_falsey
      end

      it "returns false for diagonal2 alignment" do
        board.store_move(1, " \u26ab")
        board.store_move(2, " \u26ab")
        board.store_move(2, " \u26aa")
        2.times { board.store_move(3, " \u26ab") }
        board.store_move(3, " \u26aa")
        3.times { board.store_move(4, " \u26ab") }
        board.store_move(4, " \u26aa")
        5.times { board.store_move(5, " \u26ab") }
        5.times { board.store_move(6, " \u26ab") }
        board.store_move(6, " \u26aa")
        expect(board.check_win?).to be_falsey
      end
    end
  end

  describe "#full?" do
    it "is true if the board is full" do
      6.times do
        1.upto(7) { |i| board.store_move(i, " \u26aa") }
      end
      expect(board.full?).to be_truthy
    end

    it "is false if the board is not full" do
      4.times do
        1.upto(7) { |i| board.store_move(i, " \u26aa") }
      end
      expect(board.full?).to be_falsey
    end
  end

end
