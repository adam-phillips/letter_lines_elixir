defmodule LetterLinesElixir.GameState do
  @moduledoc false
  alias LetterLinesElixir.BoardState
  alias LetterLinesElixir.GameState

  defstruct [:letter_list, :board_state, :score, :picked_words]

  @type t :: %GameState{
          letter_list: list(String.t()),
          board_state: BoardState.t(),
          score: integer(),
          picked_words: list(String.t())
        }
  def new(board_state) do
    %GameState{
      letter_list: BoardState.get_usable_letter_list(board_state),
      board_state: board_state,
      score: 0,
      picked_words: []
    }
  end
end
