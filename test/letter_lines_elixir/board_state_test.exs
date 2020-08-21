defmodule LetterLinesElixir.BoardStateTest do
  use ExUnit.Case

  alias LetterLinesElixir.BoardState
  alias LetterLinesElixir.BoardWord

  # Visualization of "good board state"

  #   0 1 2 3 4 5
  # 0           b
  # 1 c u r b   u
  # 2 h     u   n
  # 3 u     r   c
  # 4 b r u n c h
  @board_words [
    BoardWord.new(5, 0, :v, "bunch"),
    BoardWord.new(0, 1, :v, "chub"),
    BoardWord.new(3, 1, :v, "burn"),
    BoardWord.new(0, 1, :h, "curb"),
    BoardWord.new(0, 4, :h, "brunch")
  ]
  @colliding_board_words [
    BoardWord.new(5, 0, :v, "bunch"),
    BoardWord.new(5, 0, :v, "chub"),
    BoardWord.new(3, 2, :v, "burn"),
    BoardWord.new(0, 2, :h, "curb"),
    BoardWord.new(5, 0, :h, "brunch")
  ]

  describe "new/1" do
    test "returns proper width and height values" do
      assert %BoardState{width: 6, height: 5} = BoardState.new(@board_words)
    end

    test "returns expected board words" do
      words = @board_words
      assert %BoardState{words: ^words} = BoardState.new(@board_words)
    end

    @tag :skip
    test "rejects duplicate board words" do
    end

    test "will raise when multiple letters are found at the same location" do
      assert_raise RuntimeError, "Multiple letters found at 5, 0: [\"b\", \"c\"]", fn ->
        BoardState.new(@colliding_board_words)
      end
    end

    test "will raise if an empty column is found" do
      assert_raise RuntimeError, "No letters found in first column", fn ->
        BoardState.new([BoardWord.new(5, 0, :v, "bunch"), BoardWord.new(1, 0, :v, "chub")])
      end
    end

    test "will raise if an empty row is found" do
      assert_raise RuntimeError, "No letters found in first row", fn ->
        BoardState.new([BoardWord.new(0, 5, :h, "bunch"), BoardWord.new(0, 1, :h, "chub")])
      end
    end

    test "will raise if a word touches the beginning of a vertical word" do
      assert_raise RuntimeError, "Letter found before vertical word: burn", fn ->
        BoardState.new([
          BoardWord.new(0, 0, :h, "bunch"),
          BoardWord.new(0, 1, :v, "burn")
        ])
      end
    end

    test "will raise if a word touches the end of a vertical word" do
      assert_raise RuntimeError, "Letter found after vertical word: burn", fn ->
        BoardState.new([
          BoardWord.new(0, 4, :h, "bunch"),
          BoardWord.new(0, 0, :v, "burn")
        ])
      end
    end

    test "will raise if a word touches the beginning of a horizontal word" do
      assert_raise RuntimeError, "Letter found before horizontal word: bunch", fn ->
        BoardState.new([
          BoardWord.new(1, 0, :h, "bunch"),
          BoardWord.new(0, 0, :v, "burn")
        ])
      end
    end

    test "will raise if a word touches the end of a horizontal word" do
      assert_raise RuntimeError, "Letter found after horizontal word: bunch", fn ->
        BoardState.new([
          BoardWord.new(0, 0, :h, "bunch"),
          BoardWord.new(5, 0, :v, "burn")
        ])
      end
    end

    test "will raise if two horizontal, parallel words are touching" do
      assert_raise RuntimeError, "These two horizontal words are parallel and touching: urn and burn", fn ->
        BoardState.new([
          BoardWord.new(0, 0, :h, "burn"),
          BoardWord.new(1, 1, :h, "urn")
        ])
      end
    end

    test "will raise if two vertical, parallel words are touching" do
      assert_raise RuntimeError, "These two vertical words are parallel and touching: urn and burn", fn ->
        BoardState.new([
          BoardWord.new(0, 0, :v, "burn"),
          BoardWord.new(1, 1, :v, "urn")
        ])
      end
    end

    test "at least one word that uses all available letters is present" do
    end
  end

  describe "get_letter_at/3" do
    test "returns :none when there is no letter at given location" do
      board_state = BoardState.new(@board_words)
      assert :none = BoardState.get_letter_at(board_state, 1, 0)
      assert :none = BoardState.get_letter_at(board_state, 1, 3)
      assert :none = BoardState.get_letter_at(board_state, 2, 2)
      assert :none = BoardState.get_letter_at(board_state, 4, 3)
      assert :none = BoardState.get_letter_at(board_state, 0, 0)
    end

    test "returns the letter when found at given location" do
      board_state = BoardState.new(@board_words)
      assert "b" = BoardState.get_letter_at(board_state, 5, 0)
      assert "c" = BoardState.get_letter_at(board_state, 0, 1)
      assert "h" = BoardState.get_letter_at(board_state, 0, 2)
      assert "n" = BoardState.get_letter_at(board_state, 3, 4)
      assert "h" = BoardState.get_letter_at(board_state, 5, 4)
    end

    test "raises when multiple letters are found at the same location" do
      board_state = %BoardState{
        words: @colliding_board_words,
        width: 6,
        height: 5
      }

      assert_raise RuntimeError, "Multiple letters found at 5, 0: [\"b\", \"c\"]", fn ->
        BoardState.get_letter_at(board_state, 5, 0)
      end
    end
  end

  test "get_usable_letter_list/1 returns all letters from the longest BoardState word" do
    board_state = BoardState.new(@board_words)

    assert ["b", "r", "u", "n", "c", "h"] = BoardState.get_usable_letter_list(board_state)
  end

  describe "reveal_word/2" do
    test "given a BoardState and one of its words, the word is set to revealed" do
      board_state = BoardState.new(@board_words)

      assert Enum.all?(board_state.words, &(!&1.revealed?))
      {:ok, board_state} = BoardState.reveal_word(board_state, "bunch")

      assert [%BoardWord{word: "bunch", revealed?: true}] = Enum.filter(board_state.words, & &1.revealed?)
    end

    test "given a BoardState and a word it does not contain an error is returned" do
      board_state = BoardState.new(@board_words)

      assert Enum.all?(board_state.words, &(!&1.revealed?))
      assert {:error, :nothing_revealed} = BoardState.reveal_word(board_state, "branch")
    end
  end
end
