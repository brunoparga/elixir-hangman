defmodule GameTest do
  use ExUnit.Case
  # doctest Hangman.Game
  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    refute length(game.letters) == 0
    assert Enum.all?(game.letters, fn x -> String.match?(x, ~r/[a-z]/) end)
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    refute game.game_state == :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    refute game.game_state == :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")

    [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]
    |> Enum.reduce(game, fn {letter, state}, game ->
      game = Game.make_move(game, letter)
      assert game.game_state == state
      assert game.turns_left == 7
      game
    end)
  end

  test "a bad guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "a lost game is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "x")
    game = Game.make_move(game, "y")
    game = Game.make_move(game, "z")
    game = Game.make_move(game, "a")
    game = Game.make_move(game, "c")
    game = Game.make_move(game, "d")
    game = Game.make_move(game, "f")
    assert game.game_state == :lost
  end
end
