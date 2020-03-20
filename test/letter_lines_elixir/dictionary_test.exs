defmodule LetterLinesElixir.DictionaryTest do
  use ExUnit.Case

  import Mox

  alias LetterLinesElixir.Dictionary
  alias LetterLinesElixir.DictionaryFileProvider.Mock

  describe "get_file_words/0" do
    test "reads a file" do
      true
    end

    test "trims whitespace from file lines" do
      # TODO: Add tests to handle mixed case as well
      result = do_get_file_words("ABC\n DEF\n GHI ")

      assert result == ["ABC", "DEF", "GHI"]
    end
  end

  describe "words_with_letters/1" do
    test "only returns words with given letters" do
      words = ~w(desk phone pen bag)

      # `stub` here means we don't care how many times the mock is called
      # `expect` works fine, but indicates the mock will only be called once
      # and errors if it's not
      stub(Mock, :get_file_stream, fn -> string_to_stream(Enum.join(words, "\n")) end)
      assert ~w(DESK PHONE PEN) == Dictionary.words_with_letters(["E"])
      assert ~w(PHONE PEN) == Dictionary.words_with_letters(["E", "P"])
    end
  end

  def string_to_stream(string) do
    {:ok, stream} = StringIO.open(string)
    IO.binstream(stream, :line)
  end

  def do_get_file_words(string) do
    expect(Mock, :get_file_stream, fn -> string_to_stream(string) end)

    Dictionary.get_file_words()
    |> Enum.into([])
  end
end
