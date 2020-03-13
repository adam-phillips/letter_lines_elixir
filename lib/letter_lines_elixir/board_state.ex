defmodule LetterLinesElixir.BoardState do
  @moduledoc false
  alias LetterLinesElixir.{BoardState, BoardWord}

  defstruct [:width, :height, :words]
  @type t :: %BoardState{
                width: integer(),
                height: integer(),
                words: [%BoardWord{}]
             }

  def new(words) do
    {max_x, max_y} = get_max_size(words)
    %BoardState{
      width: max_x,
      height: max_y,
      words: words
    }
  end

  defp get_max_size(words) do
    Enum.reduce(words, {0, 0}, fn word, {current_max_x, current_max_y} ->
      {max_x, max_y} = BoardWord.get_max_size(word)
      {max(current_max_x, max_x), max(current_max_y, max_y)}
    end)
  end
end
