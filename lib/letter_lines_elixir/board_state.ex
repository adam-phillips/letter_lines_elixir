defmodule LetterLinesElixir.BoardState do
  @moduledoc false
  alias LetterLinesElixir.BoardState
  alias LetterLinesElixir.BoardWord

  defstruct [:width, :height, :words]

  # Guard to check for adjacent characters
  defguard off_by_one(n1, n2) when (n1 - n2) in [-1, 1]

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

    Enum.each(words, &check_word_end_touching(&1, words))

    Enum.each(words, &check_parallel_touching(&1, words))

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

  # Do not forget: test using ExUnit.CaptureIO
  def print_board(%BoardState{width: width, height: height} = board_state) do
    for y <- 0..(height - 1) do
      0..(width - 1)
      |> Enum.map(&get_display_letter_at(board_state, &1, y))
      |> Enum.join("")
      |> IO.puts()
    end
  end

  defp letter_revealed?(%BoardState{words: words}, x, y) do
    words
    |> Enum.reject(&(BoardWord.get_letter_at(&1, x, y) == :none))
    |> Enum.filter(& &1.revealed?)
    |> Kernel.!=([])
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

  defp get_display_letter_at(%BoardState{} = board_state, x, y) do
    letter = BoardState.get_letter_at(board_state, x, y)

    cond do
      letter == :none -> "#"
      !letter_revealed?(board_state, x, y) -> "."
      true -> letter
    end
  end

  defp check_word_end_touching(%BoardWord{direction: :h, x: x, y: y, word: word, size: size}, words) do
    if do_get_letter_at(words, x - 1, y) != :none do
      raise "Letter found before horizontal word: #{word}"
    end

    if do_get_letter_at(words, x + size, y) != :none do
      raise "Letter found after horizontal word: #{word}"
    end
  end

  defp check_word_end_touching(%BoardWord{direction: :v, x: x, y: y, word: word, size: size}, words) do
    if do_get_letter_at(words, x, y - 1) != :none do
      raise "Letter found before vertical word: #{word}"
    end

    if do_get_letter_at(words, x, y + size) != :none do
      raise "Letter found after vertical word: #{word}"
    end
  end

  defp check_parallel_touching(%BoardWord{} = word, words) do
    Enum.each(words, &do_check_parallel_touching(&1, word))
  end

  defp do_check_parallel_touching(%BoardWord{direction: d1}, %BoardWord{direction: d2}) when d1 != d2, do: :ok

  defp do_check_parallel_touching(%BoardWord{direction: :h, y: y1}, %BoardWord{direction: :h, y: y2})
       when not off_by_one(y1, y2),
       do: :ok

  defp do_check_parallel_touching(%BoardWord{direction: :v, x: x1}, %BoardWord{direction: :v, x: x2})
       when not off_by_one(x1, x2),
       do: :ok

  defp do_check_parallel_touching(
         %BoardWord{direction: :h, y: y1, size: size1} = word1,
         %BoardWord{direction: :h, y: y2, size: size2} = word2
       ) do
    if Range.disjoint?(y1..(y1 + size1), y2..(y2 + size2 - 1)) do
      :ok
    else
      raise "These two horizontal words are parallel and touching: #{word1} and #{word2}"
    end
  end

  defp do_check_parallel_touching(
         %BoardWord{direction: :v, x: x1, size: size1} = word1,
         %BoardWord{direction: :v, x: x2, size: size2} = word2
       ) do
    if Range.disjoint?(x1..(x1 + size1 - 1), x2..(x2 + size2 - 1)) do
      :ok
    else
      raise "These two vertical words are parallel and touching: #{word1} and #{word2}"
    end
  end
end
