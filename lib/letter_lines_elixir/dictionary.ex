defmodule LetterLinesElixir.Dictionary do
  @moduledoc """
  Module for interacting with the dictionary file, which is the authoritative source for valid words
  """
  def words_with_letters(letters) do
    get_file_words()
    |> Stream.filter(&contains_all_letters?(&1, letters))
    |> Enum.into([])
  end

  @doc """
  Use adapter pattern to open a file stream from the dictionary file, which contains almost 300k valid Scrabble words.
  From that file, trim whitespace, reject empty lines, reject lines beginning with # that represent comments,
  reject all words that are shorter than 3 characters, and finally upcase all that remains
  """
  def get_file_words do
    LetterLinesElixir.DictionaryFileProvider.get_file_stream()
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.reject(&String.starts_with?(&1, "#"))
    |> Stream.reject(&(String.length(&1) < 3))
    |> Stream.map(&String.upcase/1)
  end

  # Do not forget: Fix this. It should only return words with ALL letters, but currently
  # returns words with some letters. E.g. "E" should return nothing, but will
  # return words like "PENCIL"
  def contains_all_letters?(word, letters) do
    Enum.all?(letters, &String.contains?(word, &1))
  end
end
