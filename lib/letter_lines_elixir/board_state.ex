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

    for x <- 0..max_x, y <- 0..max_y do
      _ = do_get_letter_at(words, x, y)
    end

    if !Enum.any?(0..max_x, fn x -> do_get_letter_at(words, x, 0) != :none end) do
      raise "No letters found in first row"
    end

    if !Enum.any?(0..max_y, fn y -> do_get_letter_at(words, 0, y) != :none end) do
      raise "No letters found in first column"
    end

    Enum.each(words, &check_inappropriate_touching(&1, words))

    # Add one to max to handle zero based layout
    %BoardState{
      width: max_x + 1,
      height: max_y + 1,
      words: words
    }
  end

  def get_letter_at(%BoardState{words: words}, x, y) do
    do_get_letter_at(words, x, y)
  end

  def print_board(%BoardState{words: words, width: width, height: height}) do
    #    for x <- 0..{width -1} do
    #
    #    end
  end

  defp do_get_letter_at(words, x, y) do
    words
    |> Enum.map(&BoardWord.get_letter_at(&1, x, y))
    |> Enum.reject(&(&1 == :none))
    |> Enum.uniq()
    |> case do
      [] -> :none
      [a] -> a
      [_ | _] = list -> raise "Multiple letters found at #{x}, #{y}: #{inspect(list)}"
    end
  end

  defp check_inappropriate_touching(%BoardWord{direction: :h, x: x, y: y, word: word, size: size}, words) do
    if do_get_letter_at(words, x - 1, y) != :none do
      raise "Letter found before horizontal word: #{word}"
    end

    if do_get_letter_at(words, x + size, y) != :none do
      raise "Letter found after horizontal word: #{word}"
    end
  end

  defp check_inappropriate_touching(%BoardWord{direction: :v, x: x, y: y, word: word, size: size}, words) do
    if do_get_letter_at(words, x, y - 1) != :none do
      raise "Letter found before vertical word: #{word}"
    end

    if do_get_letter_at(words, x, y + size) != :none do
      raise "Letter found after vertical word: #{word}"
    end
  end
end
