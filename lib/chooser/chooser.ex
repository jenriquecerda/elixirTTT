defmodule Chooser do
  def def_function(mode) do
    case mode do
      "human" ->
        &Human.function/2

      "cpu" ->
        &CPU.function/2
    end
  end
end
