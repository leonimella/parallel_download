defmodule Mix.Tasks.Download do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    case Enum.count(args) do
      count when count > 0 -> ParallelDownload.begin(args)
      _ -> Mix.shell().info(print_help())
    end
  end

  defp print_help do
    "Help text"
  end
end
