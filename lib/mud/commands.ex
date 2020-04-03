defmodule Mud.Commands do
  def help_str(commands) do
    help_texts = commands
                 |> Map.keys()
                 |> Enum.map(&(commands[&1]["help"]))
                 |> Enum.join(" ")

    "Available commands:\n\n#{help_texts}"
  end

  def commands do
    %{
      "exit" => %{
        "help" => """
        exit
        """,
        "command" => fn([], _user) ->
          {:close}
        end
      },
      "help" => %{
        "help" => """
        help
        """,
        "command" => fn([], user) ->
          help_texts = help_str(Mud.Commands.commands)
          {:continue, help_texts, user}
        end
      },
    }
  end
end
