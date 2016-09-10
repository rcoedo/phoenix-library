defmodule PhoenixLibrary.Book do
  use PhoenixLibrary.Web, :model

  @derive {Poison.Encoder, only: [:id, :title, :isbn, :thumbnail, :author, :publisher, :description, :link]}

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :thumbnail, :string
    field :publisher, :string
    field :author, {:array, :string}
    field :description, :string
    field :link, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :isbn, :author, :thumbnail, :publisher, :description, :link])
    |> validate_required([:title, :isbn, :author, :thumbnail, :publisher, :description, :link])
    |> unique_constraint(:isbn)
  end
end
