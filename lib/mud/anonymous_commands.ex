defmodule Mud.AnonymousCommands do
  def commands do
    %{
      "help" => %{
        "help" => """
        help - print help
        """,
        "command" => fn([]) ->
          help_texts = Mud.Commands.help_str(Mud.AnonymousCommands.commands)
          {:continue, help_texts}
        end
      },
      "exit" => %{
        "help" => """
        exit - disconnect
        """,
        "command" => fn([]) ->
          {:close}
        end
      },
      "classes" => %{
        "help" => """
        classes - print all available player classes
        """,
        "command" => fn([]) ->
          classes = Mud.Player.get_classes
                    |> Enum.join(", ")
          {:continue, "Available classes: #{classes}"}
        end
      },
      "signup" => %{
        "help" => """
        signup <name> <password> <age> <class> - create a new user
        """,
        "command" => fn([name, password, age_str, class]) ->
          case Integer.parse(age_str) do
            {age, _} ->
              case Mud.Player.sign_up(name, password, age, class) do
                {:ok, player} ->
                  {:continue, "You have signed up succesfully with #{player.name}, you can now log in."}
                {:error, error} ->
                  {:continue, error}
              end
            :error ->
              {:continue, "Age should be a number"}
          end
        end
      },
      "login" => %{
        "help" => """
        login <name> <password> - login using username and password
        """,
        "command" => fn([name, password]) ->
          case Mud.Player.log_in(name, password) do
            {:ok, user} ->
              {:continue, "Logged in", user}
            {:error, _} ->
              {:continue, "Login failed"}
          end
        end
      },
    }
  end
end
