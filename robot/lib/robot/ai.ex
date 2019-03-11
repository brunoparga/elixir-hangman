defmodule Robot.AI do
  def choose_move(game) do
    [input | letters] = game.letters
    {Map.put(game, :letters, letters), input}
  end
end
