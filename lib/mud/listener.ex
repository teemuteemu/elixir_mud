defmodule Mud.Listener do
  require Logger

  defp read(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        data
        |> String.trim
        |> String.split
      {:error, reason} ->
        Logger.error(reason)
    end
  end

  defp serve(socket, message, user) do
    :gen_tcp.send(socket, "#{message}\n#{user.name} > ")

    socket
    |> read
    |> Mud.Parser.eval(user)
    |> case do
      {:continue, message, user} ->
        serve(socket, message, user)
      {:close} ->
        :gen_tcp.close(socket)
        Logger.info("Connection closed")
    end
  end

  defp serve(socket, message) do
    :gen_tcp.send(socket, "#{message}\n> ")

    socket
    |> read
    |> Mud.Parser.eval
    |> case do
      {:continue, message} ->
        serve(socket, message)
      {:continue, message, user} ->
        serve(socket, message, user)
      {:close} ->
        :gen_tcp.close(socket)
        Logger.info("Connection closed")
    end
  end

  defp accept(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Logger.info("New connection")
    Task.start(fn -> serve(client, "Welcome to the MUD!") end)
    accept(socket)
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
