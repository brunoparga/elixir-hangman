defmodule Robot.Client do
  alias Robot.{Player, State, Words}

  def first_game() do
    start_game()
    |> State.setup()
    |> Words.filter_by_length()
    |> Player.play()
  end

  def second_game(previous_game) do
    restart_game(previous_game)
    |> State.setup()
    |> Words.filter_by_length()
    |> Player.play()
  end

  defp start_game() do
    Hangman.new_game()
  end

  defp restart_game(game) do
    {Hangman.new_game(), game}
  end
end
