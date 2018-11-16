defmodule TextClient.Exiter do
  def message(message) do
    IO.puts(message)
    exit(:normal)
  end
end
