defmodule Robot.Mover do
  def make_move(game) do
    tally = Hangman.make_move(game.game_service, game.guess)
    %Robot.State{game | tally: tally}
  end
end
