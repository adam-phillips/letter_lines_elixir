defmodule LetterLinesElixir.GameState do
  @moduledoc false
  alias LetterLinesElixir.{GameState, BoardState}

  defstruct [:letter_list, :board_state, :score, :picked_words]

  @type t :: %GameState{
          letter_list: list(String.t()),
          board_state: BoardState.t(),
          score: integer(),
          picked_words: list(String.t())
        }
  def new(letters) do
    %GameState{
      letter_list: letters,
      board_state: generate_board_state_from_letters(letters),
      score: 0,
      picked_words: []
    }
  end

  defp generate_board_state_from_letters(_letters) do
    %BoardState{}
  end
end
