defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state." do
      player = Player.build("Elon Tusk", :kick, :heal, :punch)
      computer = Player.build("Roshan", :bash, :spell_block, :slam)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "return the current game state." do
      player = Player.build("Elon Tusk", :kick, :heal, :punch)
      computer = Player.build("Roshan", :bash, :spell_block, :slam)

      Game.start(computer, player)

      expected = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :bash, move_heal: :spell_block, move_rnd: :slam},
          name: "Roshan"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Elon Tusk"
        },
        status: :started,
        turn: :player
      }

      assert expected == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated." do
      player = Player.build("Elon Tusk", :kick, :heal, :punch)
      computer = Player.build("Roshan", :bash, :spell_block, :slam)

      Game.start(computer, player)

      expected = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :bash, move_heal: :spell_block, move_rnd: :slam},
          name: "Roshan"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Elon Tusk"
        },
        status: :started,
        turn: :player
      }

      assert expected == Game.info()

      expected_new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :bash, move_heal: :spell_block, move_rnd: :slam},
          name: "Roshan"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Elon Tusk"
        },
        status: :started,
        turn: :player
      }

      Game.update(expected_new_state)

      expected = %{expected_new_state | turn: :computer, status: :continue}

      assert expected == Game.info()
    end
  end
end
