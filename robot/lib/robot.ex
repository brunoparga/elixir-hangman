defmodule Robot do
  defdelegate play_game, to: Robot.Client
end
