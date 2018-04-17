ExUnit.start()

exclude = if Node.alive?(), do: [], else: [distributed: true]
exclude = [pending: true] ++ exclude

ExUnit.configure(
  exclude: exclude,
  trace: true
)
