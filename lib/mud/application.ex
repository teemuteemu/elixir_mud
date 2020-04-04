defmodule Mud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = if (Mix.env() == :prod), do: [Mud.Repo, Mud.Listener], else: [Mud.Repo]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mud.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
