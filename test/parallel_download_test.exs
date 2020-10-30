defmodule ParallelDownloadTest do
  use ExUnit.Case, async: true
  import Mox

  doctest ParallelDownload

  setup :verify_on_exit!

  test "Request with one valid url" do
    expected_url = "https://www.google.com"
    expected_response = "GET #{expected_url} -> status 200 in "

    ParallelDownload.MockClient
    |> expect(:fetch, fn expected_url ->
      "GET #{expected_url} -> status 200 in "
    end)

    [response | _] = ParallelDownload.begin([expected_url])

    assert String.contains?(response, expected_response) == true
  end

  test "Request with one invalid url" do
    expected_url = "https://invalid-website.blah"
    expected_response = "IGNORED #{expected_url} with reason econrefused in "

    ParallelDownload.MockClient
    |> expect(:fetch, fn expected_url ->
      "IGNORED #{expected_url} with reason econrefused in "
    end)

    [response | _] = ParallelDownload.begin([expected_url])

    assert String.contains?(response, expected_response) == true
  end

  test "Request with empty url" do
    expected_url = ""
    expected_response = "IGNORED  in"

    ParallelDownload.MockClient
    |> expect(:fetch, fn expected_url ->
      "IGNORED #{expected_url} in "
    end)

    [response | _] = ParallelDownload.begin([expected_url])

    assert String.contains?(response, expected_response) == true
  end

  test "Request with severall urls" do
    expected_urls = [
      "https://hexdocs.pm",
      "https://phoenixframework.org",
      "https://elixir-lang.org",
      "https://erlang.org",
      "https://stackoverflow.com",
      "https://invalid-url"
    ]

    ParallelDownload.MockClient
    |> expect(:fetch, Enum.count(expected_urls), fn _ -> "" end)

    ParallelDownload.begin(expected_urls)
  end

  test "Request with mixed valid and not valid urls" do
    expected_urls = [
      "https://hexdocs.pm",
      "not a url",
      "https://elixir-lang.org",
      "https://erlang.org",
      "https://invalid.blah",
      "https://invalid-url"
    ]

    ParallelDownload.MockClient
    |> expect(:fetch, Enum.count(expected_urls), fn _ -> "" end)

    ParallelDownload.begin(expected_urls)
  end
end
