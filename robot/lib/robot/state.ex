defmodule Robot.State do
  defstruct tally: nil,
            game_service: nil,
            guess: "",
            guesses: [],
            letters: ~w[e a i r t o n s l c u p m d h g b y f v w k x z q j]
end
