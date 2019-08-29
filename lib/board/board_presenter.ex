defmodule BoardPresenter do
  def to_string(board) do
    new_values =
      Enum.map(
        board,
        fn {k, _v} ->
          {:ok, value} = Board.get(board, k)

          if value == nil do
            " "
          else
            value
          end
        end
      )

    [one, two, three, four, five, six, seven, eight, nine] = new_values

    "     |     |     \n  #{one}  |  #{two}  |  #{three}  \n_____|_____|_____\n     |     |     \n  #{
      four
    }  |  #{five}  |  #{six}  \n_____|_____|_____\n     |     |     \n  #{seven}  |  #{eight}  |  #{
      nine
    }  \n     |     |     \n"
  end
end
