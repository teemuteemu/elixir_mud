alias Mud.Class
alias Mud.Repo

%Class{name: "Developer", development: 4, operations: 0, management: 0} |> Repo.insert!
%Class{name: "Devops", development: 2, operations: 2, management: 0} |> Repo.insert!
%Class{name: "Administrator", development: 0, operations: 4, management: 0} |> Repo.insert!
%Class{name: "Quality assurance", development: 2, operations: 1, management: 1} |> Repo.insert!
%Class{name: "Scrum master", development: 1, operations: 1, management: 2} |> Repo.insert!
%Class{name: "Product owner", development: 0, operations: 0, management: 4} |> Repo.insert!
