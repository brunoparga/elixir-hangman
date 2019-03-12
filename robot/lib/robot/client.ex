defmodule Robot.Client do
  alias Robot.{Player, State, Words}

  def play_game() do
    start_game()
    |> State.setup()
    |> Words.filter()
    |> Player.play()
  end

  defp start_game() do
    Hangman.new_game()
  end
end
