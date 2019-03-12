defmodule Robot.State do
  defstruct tally: nil,
            game_service: nil,
            guess: "",
            guesses: [],
            alphabet: ~w[e a i r t o n s l c u p m d h g b y f v w k x z q j],
            possible_words: []

  def setup(pid) do
    %Robot.State{game_service: pid, tally: Hangman.tally(pid)}
  end
end
