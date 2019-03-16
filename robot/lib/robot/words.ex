defmodule Robot.Words do
  def filter_by_length(game) do
    words = word_list(length(game.tally.letters))
    %Robot.State{game | possible_words: words}
  end

  defp word_list(target_length) do
    "../../assets/corncob.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\r\n/)
    |> Enum.filter(fn word -> String.length(word) == target_length end)
  end

  @doc """
    Returns all the words that could still be right. If no correct letters
    have been guessed so far, just returns the original list of possible words.
  """
  def pattern(game) do
    Enum.all?(game.tally.letters, fn x -> x == "_" end)
    |> if(do: game.possible_words, else: words_pattern(game))
  end

  defp words_pattern(game) do
    Enum.filter(game.possible_words, &possible_word?(&1, game))
  end

  defp possible_word?(word, game) do
    create_pattern(word, game.guesses) == game.tally.letters
  end

  defp create_pattern(word, guesses) do
    String.split(word, "", trim: true)
    |> Enum.map(&hide_letter(&1, guesses))
  end

  def hide_letter(letter, guesses) do
    if letter in guesses, do: letter, else: "_"
  end
end
