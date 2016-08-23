defmodule PhoenixLibrary.BookChannel do
  use Phoenix.Channel

  alias PhoenixLibrary.Repo
  alias PhoenixLibrary.Book

  def join("book:*", _message, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "join_all_books", %{books: Book |> Repo.all})
    {:noreply, socket}
  end
end
