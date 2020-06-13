defmodule LetterLinesElixir.DictionaryFileProvider do
  @moduledoc false
  @behaviour LetterLinesElixir.DictionaryFileProvider.Behaviour

  alias LetterLinesElixir.DictionaryFileProvider.FileSystemFileProvider

  def get_file_stream do
    impl().get_file_stream()
  end

  defp impl do
    Application.get_env(:letter_lines_elixir, :dictionary_file_provider, FileSystemFileProvider)
  end
end
