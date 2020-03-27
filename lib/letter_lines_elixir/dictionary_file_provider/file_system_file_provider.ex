defmodule LetterLinesElixir.DictionaryFileProvider.FileSystemFileProvider do
  @moduledoc false

  @file_path Application.app_dir(:letter_lines_elixir, "priv") |> Path.join("dictionaries/dictionary.txt")

  @behaviour LetterLinesElixir.DictionaryFileProvider.Behaviour

  def get_file_stream do
    File.stream!(@file_path)
  end
end
