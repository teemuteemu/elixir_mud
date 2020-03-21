defmodule Mud.Player do
  use Ecto.Schema

  schema "player" do
    field :name, :string
    field :password, :string
    field :age, :integer
    field :class, PlayerClass
  end

  def changeset(player, params \\ %{}) do
    player
    |> Ecto.Changeset.cast(params, [:name, :password, :age, :class])
    |> Ecto.Changeset.validate_required([:name, :password, :age, :class])
    |> Ecto.Changeset.unique_constraint(:name)
  end
end
