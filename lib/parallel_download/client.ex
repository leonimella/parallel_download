defmodule ParallelDownload.Client do
  use Tesla, only: [:get], docs: false

  def fetch(url) do
    get(url)
  end
end
