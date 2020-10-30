import Config

config :parallel_download,
  max_concurrency: 20,
  request_timeout: 1_000

import_config "#{Mix.env()}.exs"
