defmodule PhoenixLibrary.BookChannel do
  use Phoenix.Channel

  alias PhoenixLibrary.Repo
  alias PhoenixLibrary.Book

  def join("books:*", _message, socket) do
    {:ok, socket}
  end

  def join("books:" <> _book_id, _message, socket) do
    {:ok, socket}
  end

  def handle_in("get_book", %{"id" => id}, socket) do
    push(socket, "book", Book |> Repo.get(id))
    {:noreply, socket}
  end

  def handle_in("get_books", _payload, socket) do
    push(socket, "books", %{books: Book |> Repo.all})
    {:noreply, socket}
  end
end
