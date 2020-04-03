defmodule CommandTest do
  use ExUnit.Case
  doctest Mud

  test "command exit should close the connection" do
    assert Mud.Parser.eval(["exit"]) == {:close}
  end

  test "command help should print the help" do
    {:continue, reply} = Mud.Parser.eval(["help"])
    assert Regex.match?(~r/Available commands.*/, reply)
  end
end
