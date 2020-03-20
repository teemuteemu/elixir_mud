defmodule Mud.Player do
  defmodule Class do
    defmodule Skill do
      defstruct skill: "", weight: 0
    end

    defstruct title: "", skills: []

    def new(class, dev, ops, mgmt) do
      %Mud.Player.Class{
        title: class,
        skills: [
          %Mud.Player.Class.Skill{
            skill: "Development",
            weight: dev
          },
          %Mud.Player.Class.Skill{
            skill: "Operations",
            weight: ops
          },
          %Mud.Player.Class.Skill{
            skill: "Management",
            weight: mgmt
          },
        ]
      }
    end
  end

  defstruct name: "", age: 0, class: nil

  def new(name, age, class) do
    %Mud.Player{
      name: name,
      age: age,
      class: class,
    }
  end
end
