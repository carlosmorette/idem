defmodule IdemTest do
  use ExUnit.Case
  doctest Idem

  test "greets the world" do
    assert Idem.hello() == :world
  end
end
