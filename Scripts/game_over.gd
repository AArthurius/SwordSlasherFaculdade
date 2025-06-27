extends Control

const MENU = preload("res://Cenas/menu.tscn")
const SWORD_SLASHER = preload("res://Cenas/sword_slasher.tscn")
@onready var animation: AnimationPlayer = $"../Animation"
@onready var sons: Control = $"../Sons"
@onready var actual_score: Label = $"Background/Actual Score"


@onready var previous_score_1: Label = $"Background/Previous Scores Margin/Previous Scores List/Align Box 1°/Previous Score 1°"
@onready var previous_score_2: Label = $"Background/Previous Scores Margin/Previous Scores List/Align Box 2°/Previous Score 2°"
@onready var previous_score_3: Label = $"Background/Previous Scores Margin/Previous Scores List/Align Box 3°/Previous Score 3°"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../Black".show()
	hide()

func gameOver():
	show()
	animation.play("Game Over Screen appear")

func _on_play_pressed() -> void:
	sons.playSFX(2)
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	sons.playSFX(2)
	animation.play("Fade out")

func displayScores():
	var tween:Tween = create_tween()
	previous_score_1.text = str(Global.pontuações[0])
	if Global.pontuações[1] == 0:
		previous_score_2.text = "-"
	else:
		previous_score_2.text = str(Global.pontuações[1])
	if Global.pontuações[2] == 0:
		previous_score_3.text = "-"
	else:
		previous_score_3.text = str(Global.pontuações[2])
	#anima o score
	tween.tween_method(updateScore, 0, Global.pontuaçãoAtual, 1.0)

func updateScore(value: int):
	if Global.pontuações[0] == Global.pontuaçãoAtual:
		previous_score_1.text = str(value)
	actual_score.text = str(value)

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade out":
		get_tree().change_scene_to_file("res://Cenas/menu.tscn")
	if anim_name == "Game Over Screen appear":
		displayScores()
