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
