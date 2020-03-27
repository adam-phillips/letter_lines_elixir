defmodule LetterLinesElixir.BoardWordTest do
  use ExUnit.Case

  alias LetterLinesElixir.BoardWord

  test "get_max_size/1 returns correct max coordinates for a horizontal word" do
    word = BoardWord.new(0, 4, :h, "zebra")

    assert BoardWord.get_max_size(word) == {4, 4}
  end

  test "get_max_size/1 returns correct max coordinates for a vertical word" do
    word = BoardWord.new(0, 0, :v, "zebra")

    assert BoardWord.get_max_size(word) == {0, 4}
  end

  test "get_max_size/1 returns the max board size when given a word list" do
    words = [
      BoardWord.new(5, 0, :v, "bunch"),
      BoardWord.new(1, 1, :v, "chub"),
      BoardWord.new(3, 1, :v, "burn"),
      BoardWord.new(0, 3, :h, "curb"),
      BoardWord.new(0, 5, :h, "brunch")
    ]

    assert BoardWord.get_max_size(words) == {5, 5}
  end

  test "get_letter_at/3 returns word letter when found at given coordinate" do
    assert "n" == BoardWord.new(5, 0, :v, "bunch") |> BoardWord.get_letter_at(5, 2)
  end

  test "get_letter_at/3 returns nil when no letter is at the given coordinate" do
    assert nil == BoardWord.new(3, 1, :v, "burn") |> BoardWord.get_letter_at(3, 0)
    assert nil == BoardWord.new(3, 1, :v, "burn") |> BoardWord.get_letter_at(4, 1)
    assert nil == BoardWord.new(3, 1, :v, "burn") |> BoardWord.get_letter_at(3, 5)
    assert nil == BoardWord.new(3, 1, :v, "burn") |> BoardWord.get_letter_at(2, 2)
  end
end
