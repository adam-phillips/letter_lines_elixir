defmodule LetterLinesElixir do
  @moduledoc """
  Documentation for LetterLinesElixir.
  """
  alias LetterLinesElixir.BoardState
  alias LetterLinesElixir.BoardWord

  def generate_game do
    words = [
      BoardWord.new(5, 0, :v, "bunch"),
      BoardWord.new(0, 1, :v, "chub"),
      BoardWord.new(3, 1, :v, "burn"),
      BoardWord.new(0, 1, :h, "curb"),
      BoardWord.new(0, 4, :h, "brunch")
    ]

    board_state = BoardState.new(words)

    LetterLinesElixir.GameState.new(board_state)
  end
end
