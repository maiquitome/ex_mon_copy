### 1. Creating the player
```bash
iex> ExMon.Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```

### 2. Creating the player in the main module
```bash
iex> ExMon.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```

### 3. Starting the game
```bash
iex> human_pokemon = ExMonCopy.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMonCopy.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```
```bash
iex> ExMon.start_game(human_pokemon)
{:ok, #PID<0.450.0>}
```
