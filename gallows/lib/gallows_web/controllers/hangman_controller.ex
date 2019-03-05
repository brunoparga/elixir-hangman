defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def create_game(conn, _params) do
    {game, tally} = Hangman.new_game()

    conn
    |> put_session(:game, game)
    |> render("game_field.html", tally: tally)
  end

  def make_move(conn, params) do
    guess = params["make_move"]["guess"]

    tally =
      conn
      |> get_session(:game)
      |> Hangman.make_move(guess)

    put_in(conn.params["make_move"]["guess"], "")
    |> render("game_field.html", tally: tally)
  end
end