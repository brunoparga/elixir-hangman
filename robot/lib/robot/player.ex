defmodule Robot.Player do
  alias Robot.{AI, State, Summary}

  def play(%State{tally: %{game_state: :won}}) do
    IO.puts("You WON!")
    exit(:normal)
  end

  def play(%State{tally: %{game_state: :lost}}) do
    IO.puts("Sorry, you lost.")
    exit(:normal)
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
    |> AI.choose_move()
    |> update_state()
    |> make_move()
    |> play()
  end

  defp update_state({game, input}) do
    guesses = game.guesses ++ [input]
    %State{game | guess: input, guesses: guesses}
  end

  defp make_move(game) do
    tally = Hangman.make_move(game.game_service, game.guess)
    %State{game | tally: tally}
  end
end
