defmodule Mud.Player do
  use Ecto.Schema

  schema "player" do
    field :name, :string
    field :password, :string
    field :salt, :string
    field :age, :integer
    field :class, :string
  end

  def changeset(player, params \\ %{}) do
    player
    |> Ecto.Changeset.cast(params, [:name, :password, :salt, :age, :class])
    |> Ecto.Changeset.validate_required([:name, :password, :salt, :age, :class])
    |> Ecto.Changeset.unique_constraint(:name)
  end

  def format_user(user) do
    "#{user.name} - #{user.class}"
  end

  def get_classes() do
    Mud.Class
    |> Mud.Repo.all
    |> Enum.map(&(Map.get(&1, :name)))
  end

  def sign_up(name, password, age, class) do
    if Enum.member?(Mud.Player.get_classes, class) do
      salt = :crypto.strong_rand_bytes(4)
                 |> Base.encode16
                 |> String.downcase
      hashword = :crypto.hash(:sha256, salt <> password)
                 |> Base.encode16
                 |> String.downcase
      player = %Mud.Player{name: name, password: hashword, salt: salt, age: age, class: class}
                 |> Mud.Player.changeset(%{})
                 |> Mud.Repo.insert

      case player do
        {:ok, player} ->
          {:ok, player}
        {:error, _} ->
          {:error, "Sign up error"}
      end
    else
        {:error, "Invalid class"}
    end
  end

  defp fetch_player(name) do
    record = Mud.Player
             |> Mud.Repo.get_by(name: name)
    case record do
      nil ->
        {:error, :player_not_found}
      player ->
        {:ok, player}
    end
  end

  def log_in(name, password) do
    case fetch_player(name) do
      {:ok, player} ->
        hashword = :crypto.hash(:sha256, player.salt <> password)
                   |> Base.encode16
                   |> String.downcase

        if player.password == hashword do
          {:ok, player}
        else
          {:error, :log_in_error}
        end
      {:error, _} ->
        {:error, :log_in_error}
    end
  end
end
