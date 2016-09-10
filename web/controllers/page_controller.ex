defmodule PhoenixLibrary.PageController do
  use PhoenixLibrary.Web, :controller

  alias PhoenixLibrary.Repo
  alias PhoenixLibrary.Book

  def index(conn, _params) do
    conn
    |> assign(:init, Poison.encode!(%{books: Book |> Repo.all}))
    |> (render "index.html")
  end
end
