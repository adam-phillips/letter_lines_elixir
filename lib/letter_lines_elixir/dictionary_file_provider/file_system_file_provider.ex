defmodule LetterLinesElixir.DictionaryFileProvider.FileSystemFileProvider do
  @moduledoc false
  @behaviour LetterLinesElixir.DictionaryFileProvider.Behaviour

  @file_path Path.join(Application.app_dir(:letter_lines_elixir, "priv"), "dictionaries/dictionary.txt")

  def get_file_stream do
    File.stream!(@file_path)
  end
end
