defmodule Robot.Interact do
  alias Robot.{Player, State}

  def play_game() do
    start_game()
    |> setup_state()
    |> Player.play()
  end

  defp start_game() do
    Hangman.new_game()
  end

  defp setup_state(pid) do
    tally = Hangman.tally(pid)
    %State{game_service: pid, tally: tally}
  end
end
