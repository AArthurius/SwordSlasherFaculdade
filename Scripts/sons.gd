extends Control

@onready var game_over_sfx: AudioStreamPlayer2D = $"Game Over SFX"
@onready var slash_1_sfx: AudioStreamPlayer2D = $"Slash 1 SFX"
@onready var slash_2_sfx: AudioStreamPlayer2D = $"Slash 2 SFX"
@onready var ui_sfx: AudioStreamPlayer2D = $"UI SFX"

@onready var SFX:Array = [slash_1_sfx, slash_2_sfx, ui_sfx, game_over_sfx]

func playSFX(ID: int):
	if SFX[ID] != game_over_sfx:
		SFX[ID].pitch_scale = randf_range(1, 2)
	
	SFX[ID].play()
