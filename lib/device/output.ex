defmodule Output do
  def print(device \\ :stdio) do
    fn message ->
      IO.puts(device, message)
    end
  end
end
