defmodule PhoenixLibrary.BookDetailsTest do
  use PhoenixLibrary.ModelCase

  alias PhoenixLibrary.BookDetails

  @valid_attrs %{description: "some content", epub: "some content", mobi: "some content", pdf: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BookDetails.changeset(%BookDetails{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BookDetails.changeset(%BookDetails{}, @invalid_attrs)
    refute changeset.valid?
  end
end
