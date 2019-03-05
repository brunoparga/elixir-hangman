defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.Views.Helpers.GameStateHelper

  def turn(left, target) when target >= left, do: "opacity: 1;"
  def turn(_left, _target), do: "opacity: 0.4;"

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  def game_over?(state) do
    state in [:won, :lost]
  end

  def word_so_far(letters) do
    letters |> Enum.join(" ")
  end
end
