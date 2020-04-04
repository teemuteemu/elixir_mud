defmodule Mud.Repo.Migrations.CreateClass do
  use Ecto.Migration

  def change do
    create table(:class) do
      add :name, :string
      add :development, :integer
      add :operations, :integer
      add :management, :integer
    end

    create unique_index(:class, [:name])

  end
end
