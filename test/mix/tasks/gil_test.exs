defmodule Mix.Tasks.GilTest do
  use ExUnit.Case

  test "Gil#currencies :ok with 2 currencies" do
    {status, value} = Mix.Tasks.Gil.currencies(["usd", "jpy"])
    assert status == :ok
    assert value == {"usd", "jpy"}
  end

  test "Gil#currencies :ok with 1 currency" do
    {status, value} = Mix.Tasks.Gil.currencies(["jpy"])
    assert status == :ok
    assert value == {"usd", "jpy"}
  end

  test "Gil#currencies :error with usd" do
    {status} = Mix.Tasks.Gil.currencies(["usd"])
    assert status == :error
  end

  test "Gil#currencies :error with no currency" do
    {status} = Mix.Tasks.Gil.currencies([])
    assert status == :error
  end

  test "Gil#rate success" do
    rate = Mix.Tasks.Gil.rate("""
      <span class="arial_26 inlineblock pid-2091-last" id="last_last" dir="ltr">1.3983</span>
    """)
    assert rate == "1.3983"
  end

  test "Gil#rate raise RuntimeError" do
    assert_raise RuntimeError, fn -> Mix.Tasks.Gil.rate("") end
  end

  test "Gil#parse_response success" do
    body = """
      <span class="arial_26 inlineblock pid-2091-last" id="last_last" dir="ltr">1.3983</span>
    """
    response = {:ok, %HTTPoison.Response{status_code: 200, body: body}}
    parsed = Mix.Tasks.Gil.parse_response(response)
    assert parsed == {:ok, "1.3983"}
  end

  test "Gil#parse_response fail by unexpected body" do
    body = ""
    response = {:ok, %HTTPoison.Response{status_code: 200, body: body}}
    parsed = Mix.Tasks.Gil.parse_response(response)
    assert parsed == {:error, "Failed to get currency rate."}
  end

  test "Gil#parse_response fail by http not found" do
    response = {:ok, %HTTPoison.Response{status_code: 404}}
    parsed = Mix.Tasks.Gil.parse_response(response)
    assert parsed == {:error, "Failed to get currency rate."}
  end

  test "Gil#parse_response fail by http error" do
    response = {:error, %HTTPoison.Error{reason: "something wrong"}}
    parsed = Mix.Tasks.Gil.parse_response(response)
    assert parsed == {:error, "ERROR! something wrong"}
  end

  test "Gil#key_currency success" do
    assert Mix.Tasks.Gil.key_currency == "usd"
  end
end