defmodule PhoenixLibrary.PageController do
  use PhoenixLibrary.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
