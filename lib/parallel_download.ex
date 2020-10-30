defmodule ParallelDownload do
  @moduledoc """
  Documentation for `ParallelDownload`.
  """

  alias ParallelDownload.Client

  @max_concurrency 5

  def begin(urls) do
    request_stream =
      Task.async_stream(
        urls,
        fn url ->
          {:ok, start_time} = DateTime.now("Etc/UTC")

          Client.fetch(url)
          |> append_elapsed_time(start_time)
        end,
        max_concurrency: @max_concurrency
      )

    Enum.reduce(request_stream, fn {:ok, response}, _ -> IO.puts(response) end)
  end

  defp append_elapsed_time(response, start_time) do
    {:ok, end_time} = DateTime.now("Etc/UTC")
    elapsed_time = DateTime.diff(start_time, end_time, :millisecond) * -1

    response <> " #{elapsed_time}ms"
  end
end
