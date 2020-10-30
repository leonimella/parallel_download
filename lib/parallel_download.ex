defmodule ParallelDownload do
  @moduledoc """
  Documentation for `ParallelDownload`.
  """

  alias ParallelDownload.Client

  def start(urls) do
    Enum.map(urls, fn url ->
      {:ok, start_time} = DateTime.now("Etc/UTC")

      Client.fetch(url)
      |> append_elapsed_time(start_time)
      |> print_response
    end)
  end

  defp append_elapsed_time(response, start_time) do
     {:ok, end_time} = DateTime.now("Etc/UTC")
      elapsed_time = DateTime.diff(start_time, end_time, :millisecond) * -1

      response <> " #{elapsed_time}ms"
  end

  defp print_response(response), do: IO.puts(response)
end
