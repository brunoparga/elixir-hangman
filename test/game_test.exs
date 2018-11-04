defmodule GameTest do
  use ExUnit.Case
  # doctest Hangman.Game
  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.init_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    refute length(game.letters) == 0
    assert Enum.all?(game.letters, fn x -> String.match?(x, ~r/[a-z]/) end)
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.init_game() |> Map.put(:game_state, state)

      assert {^game, _tally } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.init_game()
    {game, _tally} = Game.make_move(game, "x")
    refute game.game_state == :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.init_game()
    {game, _tally} = Game.make_move(game, "x")
    refute game.game_state == :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end
end
