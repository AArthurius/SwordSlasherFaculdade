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
@onready var game_over: Control = $"../../Game Over"
@onready var tempo_de_reação_label: Label = $"../../Tempo de reação Label"
@onready var tempo_de_reação: Timer = $"../../Tempo de reação Label/Tempo de reação"
@onready var animation: AnimationPlayer = $"../../Animation"
@onready var bordas_vermelhas: TextureRect = $"../../Tempo de reação Label/Bordas Vermelhas"

var flechaScale = Vector2(0.2, 0.2)
var tempoTween = 0.25
var limite = 10
var dead = false

func _ready():
	animation.play("Fade in")
	pos_0.hide()
	pos_1.hide()
	pos_2.hide()
	pos_3.hide()
	fora.hide()
	for i in 5:
		addArrow(randi_range(0,3))

func _process(delta) -> void:
	updateArrows()
	avisoPerigo()

func avisoPerigo():
	if dead:
		bordas_vermelhas.modulate = Color(1, 1, 1, 1)
	
	var tempoTotal = snapped(tempo_de_reação.wait_time, 0.1)
	var tempoSobrando = snapped(tempo_de_reação.time_left, 0.1)
	
	tempo_de_reação_label.text = str(tempoSobrando, "s")
	bordas_vermelhas.modulate = Color(1, 1, 1, (tempoTotal - tempoSobrando)/tempoTotal)
	
	print((tempoTotal - tempoSobrando))

func gameOver():
	dead = true
	game_over.gameOver()

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
	#Desligado
	if flechas.get_children().size() < limite and not dead:
		addArrow(randi_range(0,3))
		addArrow(randi_range(0,3))
		addArrow(randi_range(0,3))

func checkArrow(swipeDirection, timeout: bool):
	if flechas.get_children().size() > 0 and not dead:
		#acerto
		if flechas.get_child(0).direction == swipeDirection and not timeout:
			player.attack(swipeDirection, flechas.get_child(0).enemyAttack, true, false)
			Global.pontuaçãoAtual
		#erro
		else:
			#acabou o tempo
			if timeout:
				player.attack(swipeDirection, flechas.get_child(0).enemyAttack, false, true)
			#errou a direção
			else:
				player.attack(swipeDirection, flechas.get_child(0).enemyAttack, false, false)
			#diminui a vida
			if barra_de_vida.get_child_count() <= 1:
				gameOver()
				barra_de_vida.get_child(-1).queue_free()
			else: 
				barra_de_vida.get_child(-1).queue_free()
		#adiciona mais uma flecha - tira a flecha usada - reinicia o timer do ataque inimigo
		addArrow(randi_range(0,3))
		flechas.get_child(0).queue_free()
		tempo_de_reação.start()

func _on_camera_2d_swipe(directionIndex: Variant) -> void:
	if $"../../Instructions".visible:
		animation.play("Fade Instructions")
		bordas_vermelhas.show()
	
	if flechas.get_child_count() > 0 and not dead:
		checkArrow(directionIndex, false)

func _on_tempo_de_reação_timeout() -> void:
	checkArrow(flechas.get_child(0).direction, true)

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade Instructions":
		$"../../Instructions".hide()
