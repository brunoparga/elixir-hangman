defmodule Hangman do
  alias Hangman.Game

  defdelegate new_game, to: Game
  defdelegate tally(game), to: Game

  def make_move(game, guess) do
    if String.match?(guess, ~r/^[a-z]$/) do
      game = Game.make_move(game, guess)
      {game, tally(game)}
    else
      {game, %{tally(game) | game_state: :invalid_guess}}
    end
  end
end
