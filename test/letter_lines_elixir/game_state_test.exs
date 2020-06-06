defmodule LetterLinesElixir.GameStateTest do
  use ExUnit.Case

  alias LetterLinesElixir.BoardState
  alias LetterLinesElixir.GameState

  @tag :skip
  test "new/1 returns an initialized game state" do
    letters = ["a", "b", "c"]
    new_game = GameState.new(letters)

    assert %GameState{} = new_game
    assert new_game.letter_list == letters
    assert %BoardState{} = new_game.board_state
    assert new_game.score == 0
    assert new_game.picked_words == []
  end
end
