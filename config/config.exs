import Config

config :mud, Mud.Repo,
  database: "mud_dev",
  username: "user",
  password: "passu",
  hostname: "localhost"

config :mud, ecto_repos: [Mud.Repo]
