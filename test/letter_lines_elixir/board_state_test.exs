defmodule LetterLinesElixir.BoardStateTest do
  use ExUnit.Case

  alias LetterLinesElixir.BoardState
  alias LetterLinesElixir.BoardWord

  # TODO: Fix the empty first row
  #   0 1 2 3 4 5
  # 0
  # 1           b
  # 2 c u r b   u
  # 3 h     u   n
  # 4 u     r   c
  # 5 b r u n c h
  @board_words [
    BoardWord.new(5, 1, :v, "bunch"),
    BoardWord.new(0, 2, :v, "chub"),
    BoardWord.new(3, 2, :v, "burn"),
    BoardWord.new(0, 2, :h, "curb"),
    BoardWord.new(0, 5, :h, "brunch")
  ]
  @bad_board_words [
    BoardWord.new(5, 0, :v, "bunch"),
    BoardWord.new(5, 0, :v, "chub"),
    BoardWord.new(3, 2, :v, "burn"),
    BoardWord.new(4, 2, :h, "curb"),
    BoardWord.new(5, 0, :h, "brunch")
  ]

  describe "new/1" do
    test "returns proper width and height values" do
      assert %BoardState{width: 6, height: 6} = BoardState.new(@board_words)
    end

    test "returns expected board words" do
      words = @board_words
      assert %BoardState{words: ^words} = BoardState.new(@board_words)
    end

    test "will raise on a bad BoardState" do
      assert_raise RuntimeError, "Multiple letters found at 5, 0: [\"b\", \"c\"]", fn ->
        BoardState.new(@bad_board_words)
      end
    end
  end

  describe "get_letter_at/3" do
    test "returns :none when there is no letter at given location" do
      board_state = BoardState.new(@board_words)
      assert :none = BoardState.get_letter_at(board_state, 1, 0)
      assert :none = BoardState.get_letter_at(board_state, 1, 4)
      assert :none = BoardState.get_letter_at(board_state, 2, 1)
      assert :none = BoardState.get_letter_at(board_state, 4, 3)
      assert :none = BoardState.get_letter_at(board_state, 5, 0)
    end

    test "returns the letter when found at given location" do
    end

    test "raises when multiple letters are found at the same location" do
      board_state = %BoardState{
        words: @bad_board_words,
        width: 6,
        height: 6
      }

      assert_raise RuntimeError, "Multiple letters found at 5, 0: [\"b\", \"c\"]", fn ->
        BoardState.get_letter_at(board_state, 5, 0)
      end
    end
  end
end
