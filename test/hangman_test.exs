defmodule HangmanTest do
  use ExUnit.Case
  # doctest Hangman

  test "a single letter is an accepted move" do
    new_game = Hangman.new_game()
    {game, tally} = Hangman.make_move(new_game, "x")
    assert game.game_state == :bad_guess
    assert tally.game_state == game.game_state
  end

  test "anything other than a single letter isn't accepted as a move" do
    new_game = Hangman.new_game()
    {game, tally} = Hangman.make_move(new_game, "foo")
    assert game == new_game
    assert tally.game_state == :invalid_guess
  end
end
