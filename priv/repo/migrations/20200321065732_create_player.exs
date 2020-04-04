defmodule Mud.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:player) do
      add :name, :string
      add :password, :string
      add :salt, :string
      add :age, :integer
      add :class, :string
    end

    create unique_index(:player, [:name])
  end
end
