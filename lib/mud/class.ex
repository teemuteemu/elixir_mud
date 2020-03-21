defmodule Mud.Class do
  use Ecto.Schema

  schema "class" do
    field :name, :string
    field :class, PlayerClass
    field :development, :integer, default: 0
    field :operations, :integer, default: 0
    field :management, :integer, default: 0
  end

  def changeset(class, params \\ %{}) do
    class
    |> Ecto.Changeset.cast(params, [:name])
    |> Ecto.Changeset.validate_required([:name])
    |> Ecto.Changeset.unique_constraint(:name)
  end
end
