defmodule MudTest do
  use ExUnit.Case
  doctest Mud

  test "parser should exit with command exit" do
    assert Mud.Parser.eval("exit") == {:noreply, :close}
  end
end
