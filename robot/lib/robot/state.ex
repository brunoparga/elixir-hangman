defmodule Robot.State do
  defstruct tally: nil,
            game_service: nil,
            guess: "",
            guesses: [],
            alphabet: ~w[e a i r t o n s l c u p m d h g b y f v w k x z q j],
            possible_words: [],
            rounds: 1000,
            wins: 0

  def setup({pid, game}) do
    %Robot.State{game_service: pid, tally: Hangman.tally(pid),
                 rounds: game.rounds - 1, wins: game.wins}
  end

  def setup(pid) do
    %Robot.State{game_service: pid, tally: Hangman.tally(pid)}
  end
end
