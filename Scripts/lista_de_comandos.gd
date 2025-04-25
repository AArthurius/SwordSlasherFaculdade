extends Control

const FLECHA = preload("res://Cenas/flecha.tscn")
@onready var player: TextureRect = $"../../Player"

@onready var pos_0: Marker2D = $Pos0
@onready var pos_1: Marker2D = $Pos1
@onready var pos_2: Marker2D = $Pos2
@onready var pos_3: Marker2D = $Pos3
@onready var fora: Marker2D = $fora
@onready var barra_de_vida: HBoxContainer = $"../../Barra de vida"
@onready var flechas: Control = $Flechas

var flechaScale = Vector2(0.2, 0.2)
var contador = 0
var tempoTween = 0.25
var limite = 10
var dead = false

func _process(delta) -> void:
	updateArrows()
	if contador > 3:
		contador = 0
	if Input.is_action_just_pressed("ui_accept"):
		addArrow(contador)
		contador += 1
	


func gameOver():
	dead = true

func addArrow(direção):
	#0 direita
	#1 esquerda
	#2 cima
	#3 baixo
	var flecha = FLECHA.instantiate()
	
	if randi_range(0, 1) == 0: 
		flecha.enemyAttack = true 
	else:
		flecha.enemyAttack = false
	
	flecha.direction = direção
	flecha.scale = flechaScale/5
	flecha.position = fora.position
	flecha.modulate = Color(1, 1, 1, 0)
	flechas.add_child(flecha)

func updateArrows():
	var tween:Tween = get_tree().create_tween()
	tween.set_parallel(true)
	for i in range(flechas.get_children().size()):
		match i:
			0:
				tween.tween_property(flechas.get_child(i), "position", pos_0.position, tempoTween)
				tween.tween_property(flechas.get_child(i), "scale", flechaScale, tempoTween)
				tween.tween_property(flechas.get_child(i), "modulate", Color(1, 1, 1, 1), tempoTween)
			1:
				tween.tween_property(flechas.get_child(i), "position", pos_1.position, tempoTween)
				tween.tween_property(flechas.get_child(i), "scale", flechaScale/2, tempoTween)
				tween.tween_property(flechas.get_child(i), "modulate", Color(1, 1, 1, 0.5), tempoTween)
			2:
				tween.tween_property(flechas.get_child(i), "position", pos_2.position, tempoTween)
				tween.tween_property(flechas.get_child(i), "scale", flechaScale/3, tempoTween)
				tween.tween_property(flechas.get_child(i), "modulate", Color(1, 1, 1, 0.333), tempoTween)
			3:
				tween.tween_property(flechas.get_child(i), "position", pos_3.position, tempoTween)
				tween.tween_property(flechas.get_child(i), "scale", flechaScale/4, tempoTween)
				tween.tween_property(flechas.get_child(i), "modulate", Color(1, 1, 1, 0.25), tempoTween)
			_:
				flechas.get_child(i).scale = flechaScale/5
				flechas.get_child(i).position = fora.position
				flechas.get_child(i).modulate = Color(1, 1, 1, 0)

func _on_aparecer_flecha_timeout() -> void:
	
	
	if flechas.get_children().size() < limite and not dead:
		addArrow(randi_range(0,3))
		addArrow(randi_range(0,3))
		addArrow(randi_range(0,3))

func checkArrow(swipeDirection):
	if flechas.get_children().size() > 0 and not dead:
		if flechas.get_child(0).direction == swipeDirection:
			player.attack(swipeDirection, flechas.get_child(0).enemyAttack)
			flechas.get_child(0).queue_free()
		else:
				if barra_de_vida.get_child_count() <= 0:
					gameOver()
				else: 
					barra_de_vida.get_child(-1).queue_free()

func _on_camera_2d_swipe(directionIndex: Variant) -> void:
	if flechas.get_child_count() > 0 and not dead:
		checkArrow(directionIndex)
