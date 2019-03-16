defmodule Robot do
  defdelegate play, to: Robot.Client, as: :first_game
end
