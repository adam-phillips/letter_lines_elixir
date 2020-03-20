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
end
