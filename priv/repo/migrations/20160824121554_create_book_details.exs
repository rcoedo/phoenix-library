defmodule PhoenixLibrary.Repo.Migrations.CreateBookDetails do
  use Ecto.Migration

  def change do
    create table(:books_details) do
      add :description, :string
      add :epub, :string
      add :mobi, :string
      add :pdf, :string
      add :book_id, references(:books, on_delete: :nothing)

      timestamps()
    end
    create index(:books_details, [:book_id])

  end
end
