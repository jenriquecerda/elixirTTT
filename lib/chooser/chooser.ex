defmodule Chooser do
  def choose(options) do
    type = List.first(options)

    case type do
      {_, _} ->
        maximize(options)

      _ ->
        Enum.random(options)
    end
  end

  defp maximize(options, max_score \\ 1) do
    filtered_scores =
      Enum.filter(
        options,
        fn {space, score} ->
          score == max_score
        end
      )

    if Enum.count(filtered_scores) > 0 do
      options =
        Enum.map(
          filtered_scores,
          fn {space, score} ->
            space
          end
        )

      Enum.random(options)
    else
      maximize(options, 0)
    end
  end
end
