defmodule ParallelDownload do
  @moduledoc """
  Documentation for `ParallelDownload`.
  """

  alias ParallelDownload.Client

  def start(urls) do
    Enum.map(urls, fn url -> Client.fetch(url) end)
  end
end
