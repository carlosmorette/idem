import Config

config :idem, Idem.Application, port: System.get_env("SERVER_PORT", "4000")

config :idem, Idem.Clients.Redis,
  host: "redis",
  port: 6379
