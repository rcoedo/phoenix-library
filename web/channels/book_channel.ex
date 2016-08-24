defmodule PhoenixLibrary.BookChannel do
  use Phoenix.Channel

  alias PhoenixLibrary.Repo
  alias PhoenixLibrary.Book

  @book_attr ~w(id title isbn thumbnail author publisher)a
  @detailed_book_attr ~w(id title isbn thumbnail author publisher book_details)a

  def join("book:*", _message, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "join_all_books", %{books: get_books})
    {:noreply, socket}
  end

  defp get_books do
    Book
    |> Repo.all
    |> Enum.map(converter(@book_attr))
  end

  defp get_detailed_books do
    Book
    |> Repo.all
    |> Repo.preload(:book_details)
    |> Enum.map(converter(@detailed_book_attr))
  end

  defp converter(attrs) do
    fn (model) -> Map.take(model, attrs) end
  end
end
