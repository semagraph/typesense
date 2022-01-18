import Config

config :typesense,
  api_url: "http://localhost:8108",
  api_key: "secret"

config :logger, :console,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n"

config :tesla,
  adapter: Tesla.Adapter.Hackney
