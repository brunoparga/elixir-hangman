defmodule HangmanTest do
  use ExUnit.Case
  # doctest Hangman

  test "a single letter is an accepted move" do
    new_game = Hangman.new_game()
    tally = Hangman.make_move(new_game, "x")
    assert tally.game_state == :bad_guess
  end
end
