defmodule Mud.Parser do
  def eval("exit") do
    {:noreply, :close}
  end

  def eval(default) do
    {:reply, default}
  end
end
