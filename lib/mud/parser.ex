defmodule Mud.Parser do

  # Actions for logged in user

  def eval([command | params], user) do
    if Map.has_key?(Mud.Commands.commands, command) do
      try do
        Mud.Commands.commands[command]["command"].(params, user)
      rescue
        FunctionClauseError -> {:continue, "Bad command", user}
      end
    else
        {:continue, "What do you mean #{user.name}?", user}
    end
  end

  def eval(_, user) do
    {:continue, "What do you mean #{user.name}?", user}
  end

  # Commands for an anonymous user

  def eval([command | params]) do
    if Map.has_key?(Mud.AnonymousCommands.commands, command) do
      try do
        Mud.AnonymousCommands.commands[command]["command"].(params)
      rescue
        FunctionClauseError -> {:continue, "Bad command"}
      end
    else
      {:continue, "eh?"}
    end
  end

  def eval(_) do
    {:continue, "eh?"}
  end
end
