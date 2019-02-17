defmodule TextClient.Interact do
  alias TextClient.{Player, State}

  def start() do
    Hangman.new_game()
    |> Hangman.initial_tally()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state({pid, tally}) do
    %State{game_service: pid, tally: tally}
  end
end
