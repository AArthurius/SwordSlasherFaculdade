extends TextureRect

@onready var inimigo: TextureRect = $"../Inimigo"
@onready var reset_sprites: Timer = $"../Reset sprites"
@onready var impacto_esquerda: TextureRect = $"../impacto esquerda"
@onready var impacto_direita: TextureRect = $"../impacto direita"

const INIMIGO_NEUTRO = preload("res://Assets/Finais/Inimigo neutro.png")

const INIMIGO_ATAQUE_DIREITA = preload("res://Assets/Finais/inimigo ataque direita.png")
const INIMIGO_ATAQUE_ESQUERDA = preload("res://Assets/Finais/inimigo ataque esquerda.png")
const INIMIGO_DEFESA_DIREITA = preload("res://Assets/Finais/Inimigo defesa direita.png")
const INIMIGO_DEFESA_ESQUERDA = preload("res://Assets/Finais/Inimigo defesa esquerda.png")

const PLAYER_ATAQUE_DIREITA = preload("res://Assets/Finais/player ataque direita.png")
const PLAYER_ATAQUE_ESQUERDA = preload("res://Assets/Finais/player ataque esquerda.png")
const PLAYER_DEFESA_DIREITA = preload("res://Assets/Finais/player defesa direita.png")
const PLAYER_DEFESA_ESQUERDA = preload("res://Assets/Finais/player defesa esquerda.png")

#faltando sprites de ataque alto e ataque baixo
var spritesPlayerAt = [PLAYER_ATAQUE_ESQUERDA, PLAYER_ATAQUE_DIREITA, PLAYER_ATAQUE_ESQUERDA, PLAYER_ATAQUE_DIREITA]
var spritesPlayerDef = [PLAYER_DEFESA_ESQUERDA, PLAYER_DEFESA_DIREITA, PLAYER_DEFESA_ESQUERDA, PLAYER_DEFESA_DIREITA]

var spritesInimigoAt = [INIMIGO_ATAQUE_ESQUERDA, INIMIGO_ATAQUE_DIREITA, INIMIGO_ATAQUE_ESQUERDA, INIMIGO_ATAQUE_DIREITA]
var spritesInimigoDef = [INIMIGO_DEFESA_ESQUERDA, INIMIGO_DEFESA_DIREITA, INIMIGO_DEFESA_ESQUERDA, INIMIGO_DEFESA_DIREITA]

var spriteID = 0

func _on_camera_2d_swipe(directionIndex: Variant) -> void:
	match directionIndex:
		0:
			#Left
			print("Left Swipe!")
		1:
			#Right
			print("Right Swipe!")
		2:
			#Down
			print("Up Swipe!")
		3:
			#Up
			print("Down Swipe!")

func attack(attackDirection, enemyAttack, hit: bool, timeout: bool):
	print("attack")
	spriteID = attackDirection
	setSprite(enemyAttack)
	if !hit:
		modulate = Color.RED

func _on_reset_sprites_timeout() -> void:
	modulate = Color.WHITE
	if spriteID in [0, 2]:
		texture = spritesPlayerDef[0]
		inimigo.texture = spritesInimigoDef[0]
	else:
		texture = spritesPlayerDef[1]
		inimigo.texture = spritesInimigoDef[1]
	impacto_esquerda.hide()
	impacto_direita.hide()

func setSprite(enemyAttack):
	if enemyAttack:
		inimigo.texture = spritesInimigoAt[spriteID]
		texture = spritesPlayerDef[spriteID]
	else:
		texture = spritesPlayerAt[spriteID]
		inimigo.texture = spritesInimigoDef[spriteID]
	
	#mostrar impacto
	if spriteID in [0, 2]:
		impacto_esquerda.show()
	elif spriteID in [1, 3]:
		impacto_direita.show()
	
	reset_sprites.start()
