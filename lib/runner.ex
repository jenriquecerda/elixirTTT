defmodule Runner do
  def main(_argv) do
    # current_path = File.cwd!
    current_path = "/home/quique/Dynamic/Elixir/tictactoe"

    human_symbol = "O"
    cpu_symol = "X"

    board = Board.create(9)

    options = fn board ->
      MiniMax.options(&WinningRules.winner/1, board, [cpu_symol, human_symbol])
    end

    input = FifoInput.get(String.to_charlist(current_path <> "/in"))
    output = FifoOutput.print(String.to_charlist(current_path <> "/out"))

    player_one = fn board -> Human.mark(board, human_symbol, input) end
    player_two = fn board -> CPU.mark(board, cpu_symol, &Chooser.choose/1, options) end
    players = [player_one, player_two]

    board = TicTacToe.play_game(board, players, WinningRules, output)
  end
end
