defmodule ParallelDownload do
  @moduledoc """
  Documentation for `ParallelDownload`.
  """

  @max_concurrency Application.fetch_env!(:parallel_download, :max_concurrency)
  @task_timeout Application.fetch_env!(:parallel_download, :task_timeout)
  @client Application.fetch_env!(:parallel_download, :client)

  @spec begin(Enumerable.t()) :: Enumerable.t(String.t())
  def begin(urls) do
    Task.async_stream(
      urls,
      fn url ->
        {:ok, start_time} = DateTime.now("Etc/UTC")

        @client.fetch(url)
        |> append_elapsed_time(start_time)
      end,
      max_concurrency: @max_concurrency,
      timeout: @task_timeout
    )
    |> Enum.map(fn {:ok, response} -> print_progress(response) end)
  end

  defp append_elapsed_time(response, start_time) do
    {:ok, end_time} = DateTime.now("Etc/UTC")
    elapsed_time = DateTime.diff(start_time, end_time, :millisecond) * -1

    response <> " #{elapsed_time}ms"
  end

  defp print_progress(response) do
    if Mix.env() != :test do
      IO.puts(response)
    end

    response
  end
end
