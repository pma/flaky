defmodule Flaky do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [worker(Flaky.Server, [])]
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def generate(base), do: Flaky.Server.generate(base)

  def numeric, do: Flaky.Server.generate(10)

  def alpha, do: Flaky.Server.generate(62)

end
