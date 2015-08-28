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
    assert_raise RuntimeError, fn ->
      Mix.Tasks.Gil.rate("")
    end
  end
end