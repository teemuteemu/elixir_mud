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

  def eval(["help"]) do
    help_texts = Mud.Commands.anonymous_commands
                 |> Map.keys()
                 |> Enum.map(&(Mud.Commands.anonymous_commands[&1]["help"]))
                 |> Enum.join(" ")
                 |> IO.inspect
    {:continue, "Available commands:\n\n#{help_texts}"}
  end

  def eval([command | params]) do
    if Map.has_key?(Mud.Commands.anonymous_commands, command) do
      try do
        Mud.Commands.anonymous_commands[command]["command"].(params)
      rescue
        FunctionClauseError -> {:error, "bad command"}
      end
    else
      {:continue, "eh?"}
    end
  end

end
