defmodule Robot.Player do
  alias Robot.{AI, Client, Mover, State, Summary}

  def play(game = %State{tally: %{game_state: :won}}) do
    IO.puts("You WON! The word was #{reveal_word(game.tally.letters)}")
    game = %State{game | wins: game.wins + 1}
    if game.rounds > 1, do: Client.second_game(game), else: quit(game)
  end

  def play(game = %State{tally: %{game_state: :lost}}) do
    IO.puts("Sorry, you lost. The word was #{reveal_word(game.tally.letters)}")
    if game.rounds > 1, do: Client.second_game(game), else: quit(game)
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
    |> Mover.make_move()
    |> play()
  end

  defp reveal_word(letters) do
    letters |> Enum.join("") |> String.upcase
  end

  def quit(game) do
    IO.puts("Won #{game.wins} out of 1000 games.")
    exit(:normal)
  end
end
