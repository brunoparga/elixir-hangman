defmodule Hangman do
  alias Hangman.Game

  defdelegate new_game, to: Game, as: :init_game
end
