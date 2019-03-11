defmodule Bot.Interact do
  alias Porcelain.Process, as: Proc
  alias Bot.Letter

  def play(game_proc) do
    play(game_proc, Proc.alive?(game_proc))
  end

  defp play(game_proc = %Proc{out: outstream}, _game_alive = true) do
    letter = Letter.new_letter
    banana = Proc.send_input(game_proc, "#{letter}\n")
    require IEx
    IEx.pry()
    play(game_proc)
  end

  defp play(game_proc, _game_alive = false) do
    Proc.stop(game_proc)
  end
end
