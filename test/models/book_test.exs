defmodule PhoenixLibrary.BookTest do
  use PhoenixLibrary.ModelCase

  alias PhoenixLibrary.Book

  @valid_attrs %{author: [], isbn: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end
