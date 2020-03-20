defmodule Mud.Listener do
  require Logger

  defp read(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        String.trim(data)
      {:error, reason} ->
        Logger.error(reason)
    end
  end

  defp serve(socket) do
    socket
    |> read
    |> Mud.Parser.eval
    |> Mud.Replier.print(socket)
    |> case do
      :true -> serve(socket)
      _ -> Logger.info("Connection closed")
    end
  end

  defp accept(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Logger.info("New connection")
    Task.start(fn -> serve(client) end)
    # accept(socket)
  end

  def start(port) do
    case :gen_tcp.listen(port, [:binary, active: false, reuseaddr: false]) do
      {:ok, socket} ->
        accept(socket)
      {:error, reason} ->
        Logger.error("Error listening #{reason}")
    end
  end
end
