import Config

config :typesense,
  #api_url: ""
  api_key: "secret"

config :logger, :console,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n"

config :tesla, adapter: Tesla.Adapter.Hackney

