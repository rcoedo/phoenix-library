defmodule PhoenixLibrary.Book do
  use PhoenixLibrary.Web, :model

  @derive {Poison.Encoder, only: [:id, :title, :isbn, :thumbnail, :author, :publisher, :book_details]}

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :thumbnail, :string
    field :publisher, :string
    field :author, {:array, :string}

    has_one :book_details, PhoenixLibrary.BookDetails

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :isbn, :author, :thumbnail, :publisher])
    |> validate_required([:title, :isbn, :author, :thumbnail, :publisher])
    |> unique_constraint(:isbn)
  end
end
