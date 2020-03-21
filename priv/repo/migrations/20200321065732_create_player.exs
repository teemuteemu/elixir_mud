defmodule Mud.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    PlayerClass.create_type

    create table(:player) do
      add :name, :string
      add :password, :string
      add :age, :integer
      add :class, PlayerClass.type()
    end
  end
end
