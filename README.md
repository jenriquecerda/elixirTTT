# Tictactoe

**To run game build it with ```mix escripts.build```**\
**Run game: ```./tictactoe```**

By default game plays human vs human.

Winning combinations are kept under the module "WinnerLogic". It will check if any of the combinations has repeated symbol, if so, there is a winner.

**CPU Intelligence**
To add different intelligence to the CPU, a function must be passed as an argument to an array of players to TicTacToe. This function must return a set of options for the Chooser to choose among them. Implementation to chooser must be done for different patterns of data sets.

```
    def choose(options) do
      type = List.first(options)

      case type do
        {_, _} ->
          maximize(options)

        _ ->
          Enum.random(options)
      end
    end
```

**MiniMax**
MiniMax is a module based on the same name algorithm. To implement MiniMax, you must call the function "options" and pass three arguments:

  - winner = The game's winner function that determines if there is a winner.
  - board = The current state of the game with blank spaces that will get evaluated for the best score.
  - [max, min] = who is the maximizing player and who is the minimizing player. Usually the max is the CPU.

**```options = fn board -> MiniMax.options(&WinningRules.winner/1, board, ["X", "O"])```**
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tictactoe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tictactoe, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tictactoe](https://hexdocs.pm/tictactoe).

