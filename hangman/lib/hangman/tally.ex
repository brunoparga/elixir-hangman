defmodule Hangman.Tally do
  @derive Jason.Encoder
  defstruct turns_left: 7,
            game_state: :initializing,
            letters: [],
            used: []

  def tally(game) do
    %Hangman.Tally{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      used: game.used |> MapSet.to_list()
    }
  end

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _not_in_word), do: "_"
end
