defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "Returns a player" do
      expected = %Player{
        life: 100,
        moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
        name: "Elon Tusk"
      }

      assert expected == ExMon.create_player("Elon Tusk", :kick, :heal, :punch)
    end
  end

  describe "start_game/1" do
    test "When the game is started, returns a message." do
      player = Player.build("Elon Tusk", :kick, :heal, :punch)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game has started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Elon Tusk", :kick, :heal, :punch)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "When the move is valid, do the move ande the computer makes a move." do
      messages =
        capture_io(fn ->
          ExMon.make_move(:punch)
        end)

      assert messages =~ "The player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "When the move is invalid, returns an error message." do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong."
    end
  end
end
