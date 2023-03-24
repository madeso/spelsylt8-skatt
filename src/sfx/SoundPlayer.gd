extends Node


onready var coin_sfx := $"Sounds/CoinSfx"
func play_coin():
	coin_sfx.play()

onready var die_sfx := $"Sounds/DieSfx"
func play_die():
	die_sfx.play()

onready var jump_sfx := $"Sounds/JumpSfx"
func play_jump():
	jump_sfx.play()

onready var treasure_sfx := $"Sounds/TreasureSfx"
func play_treasure():
	treasure_sfx.play()

onready var walljump_sfx := $"Sounds/WalljumpSfx"
func play_walljump():
	walljump_sfx.play()

onready var collect_key_sfx := $"Sounds/CollectKeySfx"
func play_collect_key():
	collect_key_sfx.play()

onready var open_chest_sfx := $"Sounds/OpenChestSfx"
func play_open_chest():
	open_chest_sfx.play()

onready var spawn_treasure_sfx := $"Sounds/SpawnTreasureSfx"
func play_spawn_treasure():
	spawn_treasure_sfx.play()
