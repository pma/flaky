defmodule FlakyTest do
  use ExUnit.Case

  setup do
    start = :os.timestamp
    flakes = Enum.map 1..10_000, fn(_) -> Flaky.generate(62) end
    finish = :os.timestamp
    {:ok, [flakes: flakes, start: start, finish: finish]}
  end

  test "flakes generated quickly", %{start: start, finish: finish} do
    time = trunc(:timer.now_diff(finish, start) / 1_000)
    assert time <= 500
  end

  test "flakes are generated in sequence", %{flakes: flakes} do
    assert flakes == Enum.sort(flakes)
  end

  test "flakes are uniq", %{flakes: flakes} do
    assert flakes == Enum.uniq(flakes)
  end

end
