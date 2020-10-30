defmodule Mix.Tasks.Download do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    if Enum.count(args) > 0 do
      [path|tail] = args

      cond do
        Enum.count(tail) == 0 && String.contains?(path, ".txt")->
          txt_file_to_list(path)
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

  defp txt_file_to_list(path) do
    File.stream!(path, [], :line)
    |> Stream.map(fn string -> String.trim(string) end)
  end

  defp print_help() do
    "Help text"
  end
end
