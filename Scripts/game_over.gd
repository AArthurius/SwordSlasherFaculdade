extends Control

const MENU = preload("res://Cenas/menu.tscn")
const SWORD_SLASHER = preload("res://Cenas/sword_slasher.tscn")
@onready var animation: AnimationPlayer = $"../Animation"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../Black".show()
	hide()

func gameOver():
	show()
	animation.play("Game Over Screen appear")

func _on_play_pressed() -> void:
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	animation.play("Fade out")

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade out":
		get_tree().change_scene_to_file("res://Cenas/menu.tscn")
