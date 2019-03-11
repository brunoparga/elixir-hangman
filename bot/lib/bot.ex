defmodule Bot do
  alias Bot.Interact

  def start do
    Porcelain.spawn("../text_client/text_client", [], in: :receive, out: :stream)
    |> Interact.play()

    # proc = %Proc{out: outstream} = Porcelain.spawn("../text_client/text_client", [], in: :receive, out: :stream)
    # IO.inspect(proc)
    # Proc.send_input(proc, "e\n")
    # Enum.into(outstream, IO.stream(:stdio, :line))
  end
end
