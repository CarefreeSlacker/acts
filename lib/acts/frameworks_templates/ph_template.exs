use Mix.Config

config :project_name, environment: :test

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :project_name, ProjectNameWeb.Endpoint,
       http: [port: 4001],
       server: false,
       presence: ProjectNameWeb.PresenceMock

# Print only warnings and errors during test
config :logger, backends: [:console], level: :warn

# Fastering password hashing library
config :bcrypt_elixir, :log_rounds, 4
