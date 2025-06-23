extends Control

@onready var inimigo: Sprite2D = $Inimigo
@onready var player: Sprite2D = $Player
@onready var reset_sprites: Timer = $"Reset sprites"
@onready var impacto_0: TextureRect = $"Impactos/impacto 0"
@onready var impacto_1: TextureRect = $"Impactos/impacto 1"
@onready var impacto_2: TextureRect = $"Impactos/impacto 2"
@onready var impacto_3: TextureRect = $"Impactos/impacto 3"
@onready var lista_de_vida_inimiga: VBoxContainer = $"Lista de vida inimiga"
@onready var animation: AnimationPlayer = $"../Animation"
@onready var pontuação: Control = $"../Pontuação"
@onready var lista_de_comandos: Control = $"../Lista de Comandos"
@onready var sons: Control = $"../Sons"


const BARRA_DE_VIDA_INIMIGA = preload("res://Cenas/barra_de_vida_inimiga.tscn")

const I_ATK_SHEET = preload("res://Assets/Finais/Objetos de ação/Inimigo/Inimigo atk.png")
const I_DEF_SHEET = preload("res://Assets/Finais/Objetos de ação/Inimigo/Inimigo def.png")
const I_PRE_SHEET = preload("res://Assets/Finais/Objetos de ação/Inimigo/Inimigo pre  atk.png")

const P_ATK_SHEET = preload("res://Assets/Finais/Objetos de ação/Player/Player atk sheet.png")
const P_DEF_SHEET = preload("res://Assets/Finais/Objetos de ação/Player/Player defesa sheet.png")
const P_PRE_SHEET = preload("res://Assets/Finais/Objetos de ação/Player/Player pre atk sheet.png")

var impactos = []

var posInimigo = Vector2(270, 655)

var sheetWidth = 500
var sheetHeight = 657

# ordem sheet - sem defesa do inimigo ainda
# 0 - esquerda
# 1 - direita
# 2 - cima
# 3 - baixo
# 4 - neutro - só na de defesa
# 5 - dano - só na de defesa 

func _on_camera_2d_double_swipe(directionIndex: Variant) -> void:
	match directionIndex:
		0:
			#Left
			print("Double Left Swipe!")
		1:
			#Right
			print("Double Right Swipe!")
		2:
			#Up
			print("Double Up Swipe!")
		3:
			#Down
			print("Double Down Swipe!")

func _on_camera_2d_swipe(directionIndex: Variant) -> void:
	match directionIndex:
		0:
			#Left
			print("Left Swipe!")
		1:
			#Right
			print("Right Swipe!")
		2:
			#Up
			print("Up Swipe!")
		3:
			#Down
			print("Down Swipe!")

func _ready() -> void:
	changeSprite(player, P_DEF_SHEET, 4)
	changeSprite(inimigo, I_DEF_SHEET, 4)
	
	impactos.append(impacto_0)
	impactos.append(impacto_1)
	impactos.append(impacto_2)
	impactos.append(impacto_3)
	
	Hideimpactos()

func attack(Direction:int, enemyAtk:bool, acerto: bool, timeout: bool, dano:bool = false, laranja:bool = false):
	if timeout:
		#player dano
		changeSprite(player, P_DEF_SHEET, 5)
		#ataque inimigo
		changeSprite(inimigo, I_ATK_SHEET, Direction)
	else:
		#player acertou o input
		if acerto:
			if laranja:
				#pre ataque player
				changeSprite(player, P_PRE_SHEET, Direction)
			else:
				if dano:
					#ataque do player
					changeSprite(player, P_ATK_SHEET, Direction)
					#danoinimigo
					changeSprite(inimigo, I_DEF_SHEET, 5)
				elif enemyAtk:
					#ataque inimigo
					changeSprite(inimigo, I_ATK_SHEET, Direction)
					#defesa player
					changeSprite(player, P_DEF_SHEET, Direction)
				else:
					#ataque do player
					changeSprite(player, P_ATK_SHEET, Direction)
					#defesa inimigo
					changeSprite(inimigo, I_DEF_SHEET, Direction)
		#player errou o input
		else:
			#ataque inimigo
			changeSprite(inimigo, I_ATK_SHEET, Direction)
			#player dano
			changeSprite(player, P_DEF_SHEET, 5)
	
	if !laranja:
		sons.playSFX(randi_range(0,1))
		impactos[Direction].show()
		reset_sprites.start()

func changeSprite(entity: Sprite2D, sheet:CompressedTexture2D, ID: int):
	#usar quando tiver os sprites de inimigos mais fortes
	var nivel = 0
	if entity == inimigo:
		nivel = Global.nivelDificuldade
	
	if nivel >= 5:
		nivel = 4
	print(nivel)
	var spriteRect = Rect2(ID * sheetWidth, nivel * sheetHeight, sheetWidth, sheetHeight)
	
	entity.texture = sheet
	entity.region_rect = spriteRect

func _on_reset_sprites_timeout() -> void:
	#voltar pro neutro
	changeSprite(player, P_DEF_SHEET, 4)
	changeSprite(inimigo, I_DEF_SHEET, 4)
	Hideimpactos()

func Hideimpactos():
	for i in impactos:
		i.hide()

func proximoInimigo():
	lista_de_comandos.pause = true
	animation.play("Inimigo transição descendo")

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Inimigo transição descendo":
		pontuação.aumentarDificuldade()
		var vidaInimiga1 = BARRA_DE_VIDA_INIMIGA.instantiate()
		lista_de_vida_inimiga.add_child(vidaInimiga1)
		for i in Global.nivelDificuldade:
			var vidaInimiga = BARRA_DE_VIDA_INIMIGA.instantiate()
			lista_de_vida_inimiga.add_child(vidaInimiga)
		changeSprite(inimigo, I_DEF_SHEET, 4)
		animation.play("Inimigo transição subindo")
	if anim_name == "Inimigo transição subindo":
		lista_de_comandos.pause = false
