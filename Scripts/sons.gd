extends Control

@onready var game_over_sfx: AudioStreamPlayer2D = $"Game Over SFX"
@onready var slash_sfx: Control = $"Slash SFX"
@onready var ui_sfx: AudioStreamPlayer2D = $"UI SFX"

@onready var SFX:Array = [ui_sfx, game_over_sfx]

func playSFX(ID: int):
	if SFX[ID] != game_over_sfx:
		SFX[ID].pitch_scale = randf_range(1, 2)
	
	SFX[ID].play()

func playSlash():
	slash_sfx.get_child(randi_range(0, 4)).play()
