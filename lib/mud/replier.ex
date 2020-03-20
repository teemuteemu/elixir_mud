defmodule Mud.Replier do
  def print(message, socket) do
    case message do
      {:reply, message} ->
        :gen_tcp.send(socket, "#{message}\n")
        :true
      {:noreply, _} ->
        :gen_tcp.close(socket)
        :false
    end
  end
end
