defmodule PhoenixLibrary.Book do
  use PhoenixLibrary.Web, :model

  @derive {Poison.Encoder, only: [:id, :title, :isbn, :thumbnail, :author]}

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :thumbnail, :string
    field :author, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :isbn, :author, :thumbnail])
    |> validate_required([:title, :isbn, :author, :thumbnail])
    |> unique_constraint(:isbn)
  end
end
