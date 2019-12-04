defmodule WarnTestTest do
  use ExUnit.Case
  doctest WarnTest

  test "greets the world" do
    assert WarnTest.hello() == :world
  end
end
