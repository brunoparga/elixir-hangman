defmodule TextClient.Interact do
  @hangman_server :"hangman@Librem-15"

  alias TextClient.{Player, State}

  def start() do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  defp new_game() do
    Node.connect(@hangman_server)

    :rpc.call(
      @hangman_server,
      Hangman,
      :new_game,
      []
    )
  end

  defp setup_state({pid, tally}) do
    %State{game_service: pid, tally: tally}
  end
end
