defmodule Mud.Game do
  def newPlayer(name, age, class_id) do
    classes = %{
      :devops => Mud.Player.Class.new("Devops", 2, 2, 0),
      :developer => Mud.Player.Class.new("Developer", 4, 0, 0),
      :admin => Mud.Player.Class.new("Administrator", 0, 4, 0),
      :scm => Mud.Player.Class.new("Scrum master", 1, 1, 2),
      :po => Mud.Player.Class.new("Product owner", 0, 0, 4),
    }

    Mud.Player.new(name, age, classes[class_id])
  end
end
