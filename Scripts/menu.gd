extends Control

@onready var animation: AnimationPlayer = $Animation
@onready var sons: Control = $Sons


const SWORD_SLASHER = preload("res://Cenas/sword_slasher.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Black.show()
	animation.play("Fade in")

func button_exit_pressed() -> void:
	sons.playSFX(0)
	get_tree().quit()

func button_play_pressed() -> void:
	sons.playSFX(0)
	animation.play("Fade out")

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade out":
		get_tree().change_scene_to_packed(SWORD_SLASHER)
