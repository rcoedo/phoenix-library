defmodule PhoenixLibrary.Repo.Migrations.AddPublisherToBook do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :publisher, :string
    end
  end
end
