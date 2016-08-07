defmodule PhoenixLibrary.PageController do
  use PhoenixLibrary.Web, :controller

  alias PhoenixLibrary.Repo
  alias PhoenixLibrary.Book

  def index(conn, _params) do
    # json(conn, Book |> Repo.all)
    render conn, "index.html"
  end
end
