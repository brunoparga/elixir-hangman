defmodule TextClient.Player do
  alias TextClient.{Exiter, Mover, Prompter, State, Summary}

  def play(%State{tally: %{game_state: :won}}) do
    Exiter.message("You WON!")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    Exiter.message("Sorry, you lost.")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Sorry, that isn't in the word.")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game, "You've already used that letter.")
  end

  def play(game), do: continue(game)

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end
end
