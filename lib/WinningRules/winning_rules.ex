defmodule WinningRules do
  @winner_combinations [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ]

  def has_winner?(board) do
    results =
      Enum.map(
        @winner_combinations,
        fn x ->
          if check_for_winner(x, board) do
            true
          end
        end
      )

    Enum.member?(results, true)
  end

  def winner(board) do
    if has_winner?(board) do
      [winner] =
        Enum.filter(
          Enum.map(
            @winner_combinations,
            fn combination ->
              if check_for_winner(combination, board) do
                combination
              end
            end
          ),
          fn x ->
            !is_nil(x)
          end
        )

      {_, symbol} = Board.get(board, Enum.fetch!(Enum.slice(winner, 0..0), 0))
      symbol
    end
  end

  defp check_for_winner(combination, board) do
    line_symbol =
      Enum.map(
        combination,
        fn x ->
          {_, value} = Board.get(board, x)

          if !is_nil(value) do
            value
          end
        end
      )

    filtered_values =
      Enum.uniq_by(
        line_symbol,
        fn x ->
          if !is_nil(x) do
            x
          end
        end
      )

    if Enum.count(filtered_values) == 1 do
      case List.first(filtered_values) do
        nil ->
          false

        _ ->
          true
      end
    end
  end
end
