defmodule Gil.Mixfile do
  use Mix.Project

  def project do
    [app: :gil,
     version: "0.0.2",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
          package: [
            contributors: ["Masatoshi Imae"],
            licenses: ["MIT"],
            links: %{"GitHub" => "https://github.com/modalsoul/gil"}
          ],
     deps: deps]
  end

  def application do
    []
  end

  defp description do
    """
    "Mix custome task for check exchange rate"
    """
  end

  defp deps do
    [{:floki, "~> 0.3"}, {:httpoison, "~> 0.7.2"}]
  end
end
