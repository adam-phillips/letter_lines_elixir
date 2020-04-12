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

    for x <- 0..(max_x - 1), y <- 0..(max_y - 1) do
      _ = do_get_letter_at(words, x, y)
    end

    %BoardState{
      width: max_x,
      height: max_y,
      words: words
    }
  end

  def get_letter_at(%BoardState{words: words}, x, y) do
    do_get_letter_at(words, x, y)
  end

  defp do_get_letter_at(words, x, y) do
    words
    |> Enum.map(&BoardWord.get_letter_at(&1, x, y))
    |> Enum.reject(&(&1 == :none))
    |> Enum.uniq()
    |> case do
         [] -> :none
         [a] -> a
         [a | _] = list -> raise "Multiple letters found at #{x}, #{y}: #{inspect(list)}"
       end
  end
end
