defmodule HangmanTest do
  use ExUnit.Case
  # doctest Hangman

  test "a single letter is an accepted move" do
    new_game = Hangman.new_game()
    {game, tally} = Hangman.make_move(new_game, "x")
    assert game.game_state == :bad_guess
    assert tally.game_state == game.game_state
  end
end
