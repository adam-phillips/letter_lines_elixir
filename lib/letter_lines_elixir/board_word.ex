defmodule LetterLinesElixir.BoardWord do
  @moduledoc """
  Module for working with a BoardWord. Each BoardWord is aware of the x/y coordinates of the start of its word,
  whether the word is presented horizontal or vertical, the string value of hte word, whether it has been revealed,
  and the length of the word
  """
  alias LetterLinesElixir.BoardWord

  defstruct [:x, :y, :direction, :word, :revealed?, :size]

  @type t :: %BoardWord{
          x: integer(),
          y: integer(),
          direction: :h | :v,
          word: String.t(),
          revealed?: boolean(),
          size: integer()
        }

  def new(x, y, direction, word) do
    %BoardWord{x: x, y: y, direction: direction, word: word, revealed?: false, size: String.length(word)}
  end

  @doc """
  Given a list of words, return the maximum x and y values for the size of the Board beginning from (0, 0)
  """
  def get_max_size(words) when is_list(words) do
    Enum.reduce(words, {0, 0}, fn word, {current_max_x, current_max_y} ->
      {max_x, max_y} = get_max_size(word)
      {max(current_max_x, max_x), max(current_max_y, max_y)}
    end)
  end

  @doc """
  Return the x/y coordinates for the last letter in a word
  """
  def get_max_size(%BoardWord{x: x, y: y, direction: :h, word: word}), do: {x + String.length(word) - 1, y}
  def get_max_size(%BoardWord{x: x, y: y, direction: :v, word: word}), do: {x, y + String.length(word) - 1}

  @doc """
  Given a BoardWord, determine if a letter exists at a given coordinate. If a letter is present, it is returned.
  Otherwise return `nil`
  """
  def get_letter_at(%BoardWord{direction: :h, y: y1}, _x, y2) when y1 != y2, do: :none
  def get_letter_at(%BoardWord{direction: :v, x: x1}, x2, _y) when x1 != x2, do: :none

  def get_letter_at(%BoardWord{direction: :h, word: word, x: x1, size: size}, x2, _y) when x2 >= x1 and x2 < size + x1,
    do: String.at(word, x2 - x1)

  def get_letter_at(%BoardWord{direction: :v, word: word, y: y1, size: size}, _x, y2) when y2 >= y1 and y2 < size + y1,
    do: String.at(word, y2 - y1)

  def get_letter_at(_, _, _), do: :none

  def get_word(%BoardWord{word: word}) do
    word
  end
end
