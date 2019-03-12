defmodule Robot.AI do
  alias Robot.{State, Words}
  def choose_move(game) do
    choose_move(game, game.tally.game_state == :initializing)
  end

  defp choose_move(game, _initializing = true) do
    [input | alphabet] = pick_letter(game)
    %State{game | guess: input,
                  guesses: game.guesses ++ [input],
                  alphabet: alphabet}
  end

  defp choose_move(game, _initializing = false) do
    game = Map.put(game, :possible_words, Words.pattern(game))
    [input | alphabet] = pick_letter(game)
    %State{game | guess: input,
                  guesses: game.guesses ++ [input],
                  alphabet: alphabet}
  end

  defp pick_letter(game) do
    game.alphabet
    |> Enum.map(&count_words(&1, game.possible_words)) # count_words returns a tuple: {"x", 437}
    |> Enum.sort(&letter_sorter/2)
    |> Enum.map(&discard_count/1)
  end

  defp count_words(letter, words) do
    count = Enum.count(words, &letter_in_word(&1, letter))
    {letter, count}
  end

  defp letter_in_word(word, letter) do
    String.contains?(word, letter)
  end

  defp letter_sorter({_, count1}, {_, count2}) do
    count1 >= count2
  end

  defp discard_count({letter, _count}), do: letter
end
