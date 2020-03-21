"""
    classes = %{
      :devops => Mud.Player.Class.new("Devops", 2, 2, 0),
      :developer => Mud.Player.Class.new("Developer", 4, 0, 0),
      :admin => Mud.Player.Class.new("Administrator", 0, 4, 0),
      :qa => Mud.Player.Class.new("QA", 2, 1, 1),
      :scm => Mud.Player.Class.new("Scrum master", 1, 1, 2),
      :po => Mud.Player.Class.new("Product owner", 0, 0, 4),
    }
"""
defmodule Mud.Game do
end
