defmodule TextClient.Summary do
  def display(game) do
    IO.puts([
      "\n",
      "Word so far: #{Enum.join(game.letters, " ")}\n",
      "Letters used: #{format_letters(game.used)}\n",
      "Guesses left: #{game.turns_left}\n"
    ])

    game
  end

  def format_letters(used) do
    {letters, _} =
      used
      |> Enum.map(fn x -> String.upcase(x) <> " -" end)
      |> Enum.join(" ")
      |> String.split_at(-2)

    letters
  end
end
