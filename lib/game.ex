defmodule ExMonCopy.Game do
  use Agent

  def start(computer, human) do
    initial_value = %{
      computer: computer,
      human: human,
      turn: :human,
      # ou :computer
      status: :started
      # ou :continue, :game_over
    }

    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end
end
