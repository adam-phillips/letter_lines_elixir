defmodule LetterLinesElixir.BoardWord do
  alias LetterLinesElixir.BoardWord

  defstruct [:x, :y, :direction, :word, :revealed?]
  @type t :: %BoardWord{
                x: integer(),
                y: integer(),
                direction: :h | :v,
                word: String.t(),
                revealed?: boolean()
             }

  def new(x, y, direction, word) do
    %BoardWord{
      x: x,
      y: y,
      direction: direction,
      word: word,
      revealed?: false
    }
  end

  def get_max_size(%BoardWord{x: x, y: y, direction: :h, word: word}), do:
    {x + String.length(word) - 1, y}

  def get_max_size(%BoardWord{x: x, y: y, direction: :v, word: word}), do:
    {x, y + String.length(word) - 1}
end
