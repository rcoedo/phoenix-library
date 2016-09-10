defmodule PhoenixLibrary.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :isbn, :string
      add :author, {:array, :string}
      add :publisher, :string
      add :description, :text
      add :thumbnail, :string
      add :link, :string

      timestamps()
    end
    create unique_index(:books, [:isbn])

  end
end
