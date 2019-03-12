defmodule Robot.Words do
  def filter(game) do
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
    Otherwise, word_pattern removes all the words ruled out by revealed letters.

    Count_revealed then checks that there are not more of a given letter than
    the ones already revealed. In other words, count_revealed filters out the
    word ADHERENCE when the letter E was guessed and the pattern is
    _ _ _ _ _ E _ _ E (since the fourth letter is not E).
  """
  def pattern(game) do
    if Enum.all?(game.tally.letters, fn x -> x == "_" end) do
      game.possible_words
    else
      pattern_bis(game)
    end
  end

  defp pattern_bis(game) do
    Enum.filter(game.possible_words, &word_pattern(&1, game.tally.letters))
    |> Enum.filter(&count_revealed(&1, game.tally.letters, game.guesses))
  end

  defp word_pattern(candidate_word, pattern) do
    String.split(candidate_word, "", trim: true)
    |> Enum.zip(pattern)
    |> Enum.all?(&validate_letter(&1))
  end

  defp validate_letter({_, "_"}), do: true
  defp validate_letter({x, x}), do: true
  defp validate_letter(_), do: false

  defp count_revealed(word, pattern, guesses) do
    word_letters = String.split(word, "", trim: true)
    word_letters -- (word_letters -- guesses)
    |> Enum.all?(&same_count(&1, word_letters, pattern))
  end

  defp same_count(letter, word, pattern) do
    count_in_word(letter, word) == count_in_pattern(letter, pattern)
  end

  defp count_in_word(letter, word) do
    Enum.count(word, fn l -> l == letter end)
  end

  defp count_in_pattern(letter, pattern) do
    Enum.count(pattern, fn l -> l == letter end)
  end
end
