defmodule Output do
  def print(message, device \\ :stdio) do
    IO.puts(device, message)
  end
end
