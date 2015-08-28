defmodule Mix.Tasks.Gil do
  use Mix.Task

  @shortdoc "Exchange rate check command"

  def run(args) do
    result = case currencies(args) do
      {:ok, {currency_a, currency_b}} ->
        case get_rate(currency_a, currency_b) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            try do
              "#{String.upcase(currency_a)}/#{String.upcase(currency_b)}: #{rate(body)}"
            rescue
              e in RuntimeError -> e.message
            end
          {:ok, %HTTPoison.Response{status_code: 404}} ->
            "Failed to get currency rate."
          {:error, %HTTPoison.Error{reason: reason}} ->
            "ERROR! #{reason}"
        end
      {:error} -> "Illegal argument"
    end

    IO.puts result

  end

  def currencies(args) do
    case args do
      [a|[b|_]] -> {:ok, {a, b}}
      ["usd"|_] -> {:error}
      [a|_] -> {:ok, {"usd", a}}
      _ -> {:error}
    end
  end

  def get_rate(currency_a, currency_b) do
    url = "http://jp.investing.com/currencies/#{String.downcase(currency_a)}-#{String.downcase(currency_b)}"
    HTTPoison.start
    HTTPoison.get(url)
  end

  def rate(body) do
    case Floki.find(body, "#last_last") do
      {_, _, [rate|_]} -> rate
      _ -> raise "Failed to get currency rate."
    end
  end
end