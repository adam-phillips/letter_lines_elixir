defmodule LetterLinesElixir.GameStateTest do
  use ExUnit.Case

  alias LetterLinesElixir.BoardState
  alias LetterLinesElixir.BoardWord
  alias LetterLinesElixir.GameState

  @board_words [
    BoardWord.new(5, 0, :v, "bunch"),
    BoardWord.new(0, 1, :v, "chub"),
    BoardWord.new(3, 1, :v, "burn"),
    BoardWord.new(0, 1, :h, "curb"),
    BoardWord.new(0, 4, :h, "brunch")
  ]

  test "new/1 returns a properly initialized game state" do
    board_state = BoardState.new(@board_words)
    new_game = GameState.new(board_state)

    assert %GameState{} = new_game
    assert new_game.letter_list == ["b", "r", "u", "n", "c", "h"]
    assert %BoardState{} = new_game.board_state
    assert new_game.score == 0
    assert new_game.picked_words == []
  end
end
