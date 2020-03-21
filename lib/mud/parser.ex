defmodule Mud.Parser do

  # Actions for logged in user

  def eval(["look", "around"], user) do
    {:continue, "you take a good look around you..", user}
  end

  def eval(["look" | things], user) do
    {:continue, "you look #{Enum.join(things, " ")}", user}
  end

  def eval(["exit"], _user) do
    {:close}
  end

  def eval(_default, user) do
    {:continue, "What do you mean #{user.name}?", user}
  end


  # Actions for an anonymous user

  def eval(["signup", name, password, age_str, class]) do
    case Integer.parse(age_str) do
      {age, _} ->
        case Mud.Player.sign_up(name, password, age, class) do
          {:ok, player} ->
            {:continue, "You have signed up succesfully with #{player.name}, you can now log in."}
          {:error, _} ->
            {:continue, "Usage: signup <name> <password> <age> <class>"}
        end
      :error ->
        {:continue, "Age should be a number"}
    end
  end

  def eval(["login", name, password]) do
    case Mud.Player.log_in(name, password) do
      {:ok, user} ->
        {:continue, "Logged in", user}
      {:error, _} ->
        {:continue, "Login failed"}
    end
  end

  def eval(["exit"]) do
    {:close}
  end

  def eval(_default) do
    {:continue, "eh?"}
  end
end
