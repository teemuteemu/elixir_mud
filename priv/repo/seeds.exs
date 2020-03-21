alias Mud.Class
alias Mud.Repo

%Class{name: "Developer", class: "developer", development: 4, operations: 0, management: 0} |> Repo.insert!
%Class{name: "Devops", class: "devops", development: 2, operations: 2, management: 0} |> Repo.insert!
%Class{name: "Administrator", class: "administrator", development: 0, operations: 4, management: 0} |> Repo.insert!
%Class{name: "Quality assurance", class: "quality_assurance", development: 2, operations: 1, management: 1} |> Repo.insert!
%Class{name: "Scrum master", class: "scrum_master", development: 1, operations: 1, management: 2} |> Repo.insert!
%Class{name: "Product owner", class: "product_owner", development: 0, operations: 0, management: 4} |> Repo.insert!
