import Config

config :parallel_download,
  max_concurrency: 5,
  task_timeout: 6_000,
  request_timeout: 5_000

import_config "#{Mix.env()}.exs"
