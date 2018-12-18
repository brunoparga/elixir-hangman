defmodule TextClient.Prompter do
  alias TextClient.{State, Exiter}

  def accept_move(game = %State{}) do
    IO.gets("Your guess: ")
    |> check_input(game)
  end

  defp check_input({:error, reason}, _) do
    Exiter.message("Game ended: #{reason}")
  end

  defp check_input(:eof, _) do
    Exiter.message("Looks like you gave up...")
  end

  defp check_input(input, game = %State{}) do
    input = String.trim(input)

    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)

      true ->
        IO.puts("Please enter a single lowercase letter")
        accept_move(game)
    end
  end
end
