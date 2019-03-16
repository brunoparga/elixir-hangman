defmodule Robot.Letter do
  def pick(game) do
    game.alphabet
    |> Enum.map(&count_words(&1, game.possible_words))
    |> Enum.sort(&letter_sorter/2)
    |> Enum.map(&discard_count/1)
  end

  defp count_words(letter, words) do
    count = Enum.count(words, &letter_in_word(&1, letter))
    {letter, count}
  end

  defp letter_in_word(word, letter), do: String.contains?(word, letter)

  defp letter_sorter({_, count1}, {_, count2}), do: count1 >= count2

  defp discard_count({letter, _count}), do: letter
end
