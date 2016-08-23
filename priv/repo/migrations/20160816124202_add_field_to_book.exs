defmodule PhoenixLibrary.Repo.Migrations.AddFieldToBook do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :thumbnail, :string
    end
  end
end
