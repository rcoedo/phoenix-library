defmodule PhoenixLibrary.PageController do
  use PhoenixLibrary.Web, :controller

  alias PhoenixLibrary.Repo
  alias PhoenixLibrary.Book

  def index(conn, _params) do
    render conn, "index.html"
  end
end
