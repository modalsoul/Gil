defmodule Mix.Tasks.Gil do
  use Mix.Task

  @shortdoc "Exchange rate check command"

  def run(args) do
    [from|[to|_]] = args
    url = "http://jp.investing.com/currencies/#{String.downcase(from)}-#{String.downcase(to)}"

    HTTPoison.start
    result = case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {_, _, [rate|_]} = Floki.find(body, "#last_last")
        "#{String.upcase(from)}/#{String.upcase(to)}: #{rate}"
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        "ERROR! #{reason}"
    end

    IO.puts result
  end
end