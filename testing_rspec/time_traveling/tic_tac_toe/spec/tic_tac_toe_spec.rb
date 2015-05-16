require "tic_tac_toe"


describe "Game" do
  let(:game) { Game.new }

  context "when x makes a row" do
    it "triggers the game over seqences" do
      allow(game).to receive(:start_game).and_return(1, 4, 2, 7, 3)
      expect(game.player.game_over).to eq(true)
    end
  end

end

# check if game initialises.
# check if players are assigned.
# check if game is started.
# check that board prints with only 1..9 in boxes.
# check that player 1 is x.
# check that player 1 goes first.
# check that false moves are rejected.
# check that moves are stored.
# check that the board shows correctly after a selection.
# check that players swap after ech turn.
# check that winning moves end the game.
# for both players.
# check winning message.
# check that a stalemate ends the game.
# check stalemate message.
