defmodule Mud.Commands do
  def anonymous_commands do
    %{
      "exit" => %{
        "help" => """
        exit
        """,
        "command" => fn([]) ->
          {:close}
        end
      },
      "help" => %{
        "help" => """
        help
        """,
        "command" => fn([]) ->
          help_texts = Mud.Commands.anonymous_commands
                       |> Map.keys()
                       |> Enum.map(&(Mud.Commands.anonymous_commands[&1]["help"]))
                       |> Enum.join(" ")
                       |> IO.inspect
          {:continue, "Available commands:\n\n#{help_texts}"}
        end
      },
      "signup" => %{
        "help" => """
        signup <name> <password> <age> <class>
        """,
        "command" => fn([name, password, age_str, class]) ->
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
      },
      "login" => %{
        "help" => """
        login <name> <password>
        """,
        "command" => fn([name, password]) ->
          case Mud.Player.log_in(name, password) do
            {:ok, user} ->
              {:continue, "Logged in", user}
            {:error, _} ->
              {:continue, "Login failed"}
          end
        end
      }
    }
  end
end
