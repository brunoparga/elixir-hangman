defmodule Robot do
  defdelegate play_game, to: Robot.Interact
end
