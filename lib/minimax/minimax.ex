defmodule MiniMax do
  def options(winner, board, [max, min]) do
    current_player = max

    available_spaces = Board.blank_spaces(board)

    Enum.map(
      available_spaces,
      fn space ->
        branch = calculate_branch(winner, board, {space, current_player, [max, min]})
        [node] = Map.keys(branch)
        value = minimax(branch, space, true)

        {node, value}
      end
    )
  end

  defp minimax(result, space, max) do
    node = Map.get(result, space)

    if is_list(node) do
      max = !max

      if Enum.count(node) == 1 do
        [node] = node
        [k] = Map.keys(node)
        minimax(node, k, max)
      else
        points =
          Enum.map(
            node,
            fn move ->
              [k] = Map.keys(move)
              minimax(move, k, max)
            end
          )

        case max do
          true ->
            Enum.max(points)

          false ->
            Enum.min(points)
        end
      end
    else
      node
    end
  end

  def calculate_branch(winner, board, movement) do
    {space, current_player, [max, min]} = movement

    {_, marked_board} = Board.mark(board, space, current_player)

    if !Board.is_full?(marked_board) && is_nil(winner.(marked_board)) do
      nested_results(winner, marked_board, current_player, max, min, space)
    else
      case !is_nil(winner.(marked_board)) do
        true ->
          case winner.(marked_board) == max do
            true ->
              %{space => 1}

            false ->
              %{space => -1}
          end

        false ->
          if Board.is_full?(marked_board) do
            %{space => 0}
          end
      end
    end
  end

  defp nested_results(winner, board, current_player, max, min, space) do
    available_spaces = Board.blank_spaces(board)
    [current_player] = [max, min] -- [current_player]

    scores =
      Enum.map(
        available_spaces,
        fn space ->
          calculate_branch(winner, board, {space, current_player, [max, min]})
        end
      )

    Enum.zip([space], [scores]) |> Enum.into(%{})
  end
end
