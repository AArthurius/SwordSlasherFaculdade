extends Control

const FLECHA = preload("res://Cenas/flecha.tscn")
@onready var ação: Control = $"../Objetos de ação"
@onready var pos_0: Marker2D = $Pos0
@onready var pos_1: Marker2D = $Pos1
@onready var pos_2: Marker2D = $Pos2
@onready var pos_3: Marker2D = $Pos3
@onready var fora: Marker2D = $fora
@onready var barra_de_vida: HBoxContainer = $"../Objetos de ação/Barra de Vida"
@onready var flechas: Control = $Flechas
@onready var game_over: Control = $"../Game Over"
@onready var tempo_de_reação_label: Label = $"../Tempo de reação Label"
@onready var tempo_de_reação: Timer = $"../Tempo de reação Label/Tempo de reação"
@onready var animation: AnimationPlayer = $"../Animation"
@onready var bordas_vermelhas: TextureRect = $"../Tempo de reação Label/Bordas Vermelhas"
@onready var pontuação: Control = $"../Pontuação"
@onready var lista_de_vida_inimiga: VBoxContainer = $"../Objetos de ação/Lista de vida inimiga"
@onready var inimigo: Sprite2D = $"../Objetos de ação/Inimigo"
@onready var player: Sprite2D = $"../Objetos de ação/Player"



var pause:bool = false;
var flechaScale = Vector2(0.3, 0.3)
var tempoTween = 0.25
var limite = 10
var dead = false

var setaCoraçãoContadorMax = 10
var setaCoraçãoContador = 0

var setaContadorLaranja = 0

@onready var tamanhoTextura = $Pos0/Flecha.texture.get_height()/2

func _ready():
	setaCoraçãoContador = setaCoraçãoContadorMax
	
	Global.pontuaçãoAtual = 0
	animation.play("Fade in")
	pos_0.hide()
	ajustarDistancia()
	
	bordas_vermelhas.modulate = Color(1,1,1,0)
	for i in 5:
		addArrow(randi_range(0,3))

func _process(delta) -> void:
	tempo_de_reação.paused = pause
	updateArrows()
	avisoPerigo()
	
	if Input.is_action_just_pressed("ui_accept"):
		var clone = barra_de_vida.get_child(-1).duplicate()
		barra_de_vida.add_child(clone)
		damageInimigo(6)

func ajustarDistancia():
	pos_1.position.y = pos_0.position.y + (tamanhoTextura*flechaScale.y) + (tamanhoTextura*(flechaScale.y/2))
	pos_2.position.y = pos_1.position.y + (tamanhoTextura*flechaScale.y/2) + (tamanhoTextura*(flechaScale.y/3))
	pos_3.position.y = pos_2.position.y + (tamanhoTextura*flechaScale.y/3) + (tamanhoTextura*(flechaScale.y/4))
	fora.position.y = pos_3.position.y + (tamanhoTextura*flechaScale.y/4) + (tamanhoTextura*(flechaScale.y/5))

func avisoPerigo():
	if tempo_de_reação.is_stopped():
		bordas_vermelhas.modulate = Color(1, 1, 1, 0)
		return
	if dead:
		bordas_vermelhas.modulate = Color(1, 1, 1, 1)
		return
	
	var tempoTotal = snapped(tempo_de_reação.wait_time, 0.1)
	var tempoSobrando = snapped(tempo_de_reação.time_left, 0.1)
	
	#tempo_de_reação_label.text = str(tempoSobrando, "s")
	bordas_vermelhas.modulate = Color(1, 1, 1, (tempoTotal - tempoSobrando)/tempoTotal)

func gameOver():
	dead = true
	game_over.gameOver()
	Global.gameOver()

func addArrow(direção):
	#0 direita
	#1 esquerda
	#2 cima
	#3 baixo
	var flecha = FLECHA.instantiate()
	
	# /// Tipo de flecha é decidido no _ready() da flecha\\\
	# 0 = Azul
	# 1 = Laranja
	# 2 = Cinza
	# 3 = Coração
	# 4 = Double
	if setaCoraçãoContador > 0:
		flecha.SetasPossiveis[3] = false
	else:
		flecha.SetasPossiveis[3] = true
	
	if setaContadorLaranja > 0:
		flecha.SetasPossiveis[1] = false
	else:
		flecha.SetasPossiveis[1] = true
	
	if flechas.get_child_count() > 4:
		if flechas.get_child(-1).direction == direção:
			direção = randi_range(0, 3)
	
	if flechas.get_child_count() > 0:
		if flechas.get_child(-1).setaAtual == flechas.get_child(-1).Tipo.LARANJA:
			for i in flecha.SetasPossiveis:
				if i != 0:
					flecha.SetasPossiveis[i] = false
			flecha.dano = true
			flecha.enemyAtk= false 
			match flechas.get_child(-1).direction:
				0:
					direção = 1
				1:
					direção = 0
				2:
					direção = 3
				3:
					direção = 2
	
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
				if flechas.get_child(i).setaAtual == flechas.get_child(i).Tipo.CINZA:
					if flechas.get_child(i).direction > 1:
						tween.tween_property(flechas.get_child(i), "rotation", deg_to_rad(270), tempoTween)
					else:
						tween.tween_property(flechas.get_child(i), "rotation", deg_to_rad(180), tempoTween)
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

func checkArrow(swipeDirection, timeout: bool):
	if pause:
		return
	
	if flechas.get_children().size() > 0 and not dead:
		#acerto
		if flechas.get_child(0).direction == swipeDirection and not timeout:
			pontuação.acerto(snapped(tempo_de_reação.time_left, 0.1)) #pontuar
			if flechas.get_child(0).setaAtual == flechas.get_child(0).Tipo.LARANJA: #se for laranja
				ação.attack(swipeDirection, flechas.get_child(0).enemyAtk, true, false, false, true)
			else: # se não for laranja
				shake(player, 5)
				shake(inimigo, 10)
				if flechas.get_child(0).dano == true: #se for logo depois de uma laranja da dano no inimigo
					ação.attack(swipeDirection, flechas.get_child(0).enemyAtk, true, false, true, false)
					damageInimigo()
				else:
					ação.attack(swipeDirection, flechas.get_child(0).enemyAtk, true, false, false, false)
			
			checkTipo(flechas.get_child(0), true)
		#erro
		else:
			shake(player, 10)
			shake(inimigo, 5)
			shake(barra_de_vida, 10)
			#acabou o tempo
			if timeout:
				ação.attack(swipeDirection, flechas.get_child(0).enemyAtk, false, true)
			#errou a direção
			else:ação.attack(swipeDirection, flechas.get_child(0).enemyAtk, false, false)
			#diminui a vida
			if barra_de_vida.get_child_count() <= 1:
				gameOver()
				barra_de_vida.get_child(-1).queue_free()
			else: 
				barra_de_vida.get_child(-1).queue_free()
			checkTipo(flechas.get_child(0))
		#adiciona mais uma flecha - tira a flecha usada - reinicia o timer do ataque inimigo
		afterCheck()

func checkTipo(seta, acerto = false):
	match seta.setaAtual:
		seta.Tipo.AZUL:
			pass
			#nada de diferente
		seta.Tipo.LARANJA:
			#não reinicia o timer de reação e usa o sprite de pre ataque (na função dentro do player)
			return
		seta.Tipo.CINZA:
			pass
			#inverte a direção quando está no penultimo slot (na função updateArrows()) 
		seta.Tipo.CORAÇÃO:
			if acerto:
				if barra_de_vida.get_child_count() < 3:
					var clone = barra_de_vida.get_child(-1).duplicate()
					barra_de_vida.add_child(clone)
				setaCoraçãoContador = setaCoraçãoContadorMax
		seta.Tipo.DOUBLE:
			pass
	if acerto:
		setaContadorLaranja = 0
	tempo_de_reação.start()

func afterCheck():
	setaCoraçãoContador -= 1
	addArrow(randi_range(0,3))
	flechas.get_child(0).queue_free()
	

func _on_camera_2d_swipe(directionIndex: Variant) -> void:
	if pause:
		return
	if $"../Instructions".visible:
		animation.play("Fade Instructions")
		bordas_vermelhas.show()
	
	if flechas.get_child_count() > 0 and not dead:
		checkArrow(directionIndex, false)

func _on_tempo_de_reação_timeout() -> void:
	checkArrow(flechas.get_child(0).direction, true)

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade Instructions":
		$"../Instructions".hide()

func damageInimigo(amount:int = 1):
	if lista_de_vida_inimiga.get_child(-1) == null:
		return
	
	for  i in amount:
		if lista_de_vida_inimiga.get_child(-1).get_child_count() > 1:
			lista_de_vida_inimiga.get_child(-1).get_child(-1).queue_free()
		else:
			lista_de_vida_inimiga.get_child(-1).queue_free()
			if lista_de_vida_inimiga.get_child_count() < 2:
				ação.proximoInimigo()
	
	shake(lista_de_vida_inimiga, 10)

func shake(node: Node, factor:int = 5):
	var tween = create_tween()
	var originalPos = node.position
	
	tween.tween_property(node, "position", originalPos + Vector2(randi_range(0,factor) * sign(randf() - 0.5), randi_range(0,factor) * sign(randf() - 0.5)), 0.05)
	tween.tween_property(node, "position", originalPos + Vector2(randi_range(0,factor) * sign(randf() - 0.5), randi_range(0,factor) * sign(randf() - 0.5)), 0.05)
	tween.tween_property(node, "position", originalPos, 0.05)
	lista_de_vida_inimiga. position = Vector2(8, 0)
