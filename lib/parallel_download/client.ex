defmodule ParallelDownload.Client do
  use Tesla

  @timeout Application.fetch_env!(:parallel_download, :request_timeout)

  defp client() do
    Tesla.client([
      {Tesla.Middleware.Timeout, timeout: @timeout}
    ])
  end

  def fetch(url) do
    client()
    |> get(url)
    |> parse_response(url)
  end

  defp parse_response({:ok, %{status: status}}, url) do
    "GET #{url} -> status #{status} in"
  end

  defp parse_response({:error, %{status: status}}, url) do
    "ERROR #{url} -> status #{status} in"
  end

  defp parse_response({:error, reason}, url) when is_atom(reason) do
    "IGNORED #{url} with reason #{reason} in"
  end

  defp parse_response({:error, _}, url) do
    "IGNORED #{url} in"
  end
end
