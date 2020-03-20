defmodule LetterLinesElixir.Dictionary do
  def words_with_letters(letters) do
    get_file_words
    |> Stream.filter(&contains_all_letters?(&1, letters))
    |> Enum.into([])
  end

  def get_file_words() do
    LetterLinesElixir.DictionaryFileProvider.get_file_stream()
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.reject(&String.starts_with?(&1, "#"))
    |> Stream.reject(&(String.length(&1) < 3))
    |> Stream.map(&String.upcase/1)
  end

  # TODO: Fix this. It should only return words with ALL letters, but currently
  # returns words with some letters. E.g. "E" should return nothing, but will
  # return words like "PENCIL"
  def contains_all_letters?(word, letters) do
    letters
    |> Enum.all?(&String.contains?(word, &1))
  end
end
