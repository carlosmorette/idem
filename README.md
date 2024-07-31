# Idem

"Idempotency flow" for payment system.

Idea: 2 servers share an cache. The server store requests attempts to avoid duplicated payments.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `idem` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:idem, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/idem>.

