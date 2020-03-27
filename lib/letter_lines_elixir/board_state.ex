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
    {max_x, max_y} = BoardWord.get_max_size(words)

    %BoardState{
      width: max_x,
      height: max_y,
      words: words
    }
  end
end
