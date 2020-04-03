defmodule Mud.Commands do
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
          help_texts = Mud.Commands.commands
                       |> Map.keys()
                       |> Enum.map(&(Mud.Commands.commands[&1]["help"]))
                       |> Enum.join(" ")
                       |> IO.inspect
          {:continue, "Available commands:\n\n#{help_texts}", user}
        end
      },
    }
  end
end
