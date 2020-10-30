defmodule ParallelDownload do
  @moduledoc """
  Documentation for `ParallelDownload`.
  """
  alias ParallelDownload.Client

  @max_concurrency Application.fetch_env!(:parallel_download, :max_concurrency)
  @task_timeout Application.fetch_env!(:parallel_download, :task_timeout)

  def begin(urls) do
    request_stream =
      Task.async_stream(
        urls,
        fn url ->
          {:ok, start_time} = DateTime.now("Etc/UTC")

          Client.fetch(url)
          |> append_elapsed_time(start_time)
        end,
        max_concurrency: @max_concurrency,
        timeout: @task_timeout
      )

    Enum.map(request_stream, fn {:ok, response} -> IO.puts(response) end)
  end

  defp append_elapsed_time(response, start_time) do
    {:ok, end_time} = DateTime.now("Etc/UTC")
    elapsed_time = DateTime.diff(start_time, end_time, :millisecond) * -1

    response <> " #{elapsed_time}ms"
  end
end
