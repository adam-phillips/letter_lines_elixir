defmodule LetterLinesElixir.DictionaryFileProvider.Behaviour do
  @moduledoc false

  @callback get_file_stream :: Stream.t()
end
