defmodule ExMon do
  alias ExMon.{Player, Game}

  @computer_name "Roshan"

  def create_player(name, move_avg, move_heal, move_rnd) do
    Player.build(name, move_avg, move_heal, move_rnd)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:bash, :spell_block, :slam)
    |> Game.start(player)
  end
end
