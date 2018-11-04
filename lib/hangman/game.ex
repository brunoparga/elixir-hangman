defmodule Hangman.Game do
  defstruct turns_left: 7,
            game_state: :initializing,
            letters: [],
            used: []

  def init_game do
    %Hangman.Game{letters: Dictionary.random_word() |> String.codepoints()}
  end

  def make_move(game = %{game_state: state}, _) when state in [:won, :lost] do
    {game, tally(game)}
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, guess in game.used)
    {game, tally(game)}
  end

  def tally(_game) do
    123
  end

  def accept_move(game, _guess, already_guessed) when already_guessed do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, [guess | game.used])
  end
end
