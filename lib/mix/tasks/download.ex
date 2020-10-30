defmodule Mix.Tasks.Download do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    if Enum.count(args) > 0 do
      [path|tail] = args

      cond do
        Enum.count(tail) == 0 && String.contains?(path, ".txt")->
          File.stream!(path, [], :line)
          |> Stream.map(fn string -> String.trim(string) end)
          |> ParallelDownload.begin()
        Enum.count(tail) > 0 ->
          ParallelDownload.begin(args)
        true ->
          IO.puts(print_help())
      end
    else
      IO.puts(print_help())
    end
  end

  defp print_help() do
    """
    Welcome to the Parallel Download App
    The purpose of this apps is to make GET requests to an given list of urls. You can pass them as an argument or via a .txt file.
    Please, refer to README.md file for more details\n
    Usage:
      Passing urls directly as argunments:
      - mix download http://first-url.com http://second-url.com\n
      Passing urls through a .txt file:
      - mix download /path/to/file/url.txt
      IMPORTANT: A valid .txt file consists of one url per line
    """
  end
end
