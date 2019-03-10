defmodule Hangman.Game do
  defstruct turns_left: 7,
            game_state: :initializing,
            letters: [],
            used: MapSet.new()

  def new_game(word), do: %Hangman.Game{letters: word |> String.codepoints()}

  def new_game do
    Dictionary.random_word()
    |> new_game
  end

  def make_move(game = %{game_state: state}, _) when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_move(game, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
    |> return_with_tally()
  end

  ###################################################################

  defp return_with_tally(game), do: {game, Hangman.Tally.tally(game)}

  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _not_yet_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won

    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %{turns_left: 1}, _not_good_guess) do
    %{game | game_state: :lost, turns_left: 0}
  end

  defp score_guess(game = %{turns_left: turns_left}, _not_good_guess) do
    %{game | game_state: :bad_guess, turns_left: turns_left - 1}
  end

  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess
end
