Gil
===
[![Build Status](https://travis-ci.org/modalsoul/Gil.svg?branch=master)](https://travis-ci.org/modalsoul/Gil)
[![Hex.pm](https://img.shields.io/hexpm/v/gil.svg)](https://hex.pm/packages/gil)

Gil is a mix custom task for checking exchange rate.

## Installation

* mix.exs
```elixir
def deps do
  [{:gil, "~> 0.0.2"}]
end
```

## Usage

Get USD/EUR rate.

```elixir
> mix gil USD EUR
USD/EUR: 0.8850
```

Use USD as a key currency.

```elixir
> mix gil EUR
USD/EUR: 0.8850
```

## License

Copyright (C) 2015 Masatoshi Imae([@modal_soul](http://twitter.com/modal_soul))

Distributed under the MIT License.