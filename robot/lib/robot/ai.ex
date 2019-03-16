defmodule Robot.AI do
  alias Robot.{Letter, State, Words}
  def choose_move(game) do
    choose_move(game, game.tally.game_state == :initializing)
  end

  defp choose_move(game, _initializing = true) do
    choose_letter(game)
  end

  defp choose_move(game, _initializing = false) do
    Map.put(game, :possible_words, Words.pattern(game))
    |> choose_letter()
  end

  defp choose_letter(game) do
    [input | alphabet] = Letter.pick(game)
    %State{game | guess: input,
                  guesses: game.guesses ++ [input],
                  alphabet: alphabet}
  end
end
