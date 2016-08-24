defmodule PhoenixLibrary.BookDetails do
  use PhoenixLibrary.Web, :model

  schema "books_details" do
    field :description, :string
    field :epub, :string
    field :mobi, :string
    field :pdf, :string
    belongs_to :book, PhoenixLibrary.Book

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :epub, :mobi, :pdf])
    |> validate_required([:description, :epub, :mobi, :pdf])
  end
end
