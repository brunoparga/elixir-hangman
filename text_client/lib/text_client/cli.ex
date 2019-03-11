defmodule TextClient.CLI do
  def main(_) do
    Node.start(:text_client, :shortnames)
    TextClient.start()
  end
end
