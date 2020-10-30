defmodule ParallelDownload.ClientBehaviour do
  @callback fetch(binary()) :: String.t()
end
