extends TextureRect

@onready var inimigo: TextureRect = $"../Inimigo"
@onready var reset_sprites: Timer = $"../Reset sprites"
@onready var impacto_esquerda: TextureRect = $"../impacto esquerda"
@onready var impacto_direita: TextureRect = $"../impacto direita"

const INIMIGO_ATAQUE_DIREITA = preload("res://Assets/Finais/inimigo ataque direita.png")
const INIMIGO_ATAQUE_ESQUERDA = preload("res://Assets/Finais/inimigo ataque esquerda.png")
const INIMIGO_NEUTRO = preload("res://Assets/Finais/Inimigo neutro.png")
const PLAYER_ATAQUE_DIREITA = preload("res://Assets/Finais/player ataque direita.png")
const PLAYER_ATAQUE_ESQUERDA = preload("res://Assets/Finais/player ataque esquerda.png")
const PLAYER_DEFESA = preload("res://Assets/Finais/player defesa.png")

var direita = true

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

func attack(direction, enemyAttack, hit: bool, timeout: bool):
	resetSprites()
	inimigo.flip_h = false
	flip_h = false
	if enemyAttack or timeout:
		texture = PLAYER_DEFESA
		match direction:
			0:
				inimigo.texture = INIMIGO_ATAQUE_ESQUERDA
				flip_h = false
				direita = false
				impacto_esquerda.show()
			1:
				inimigo.texture = INIMIGO_ATAQUE_DIREITA
				direita = true
				flip_h = true
				impacto_direita.show()
			2:
				inimigo.texture = INIMIGO_ATAQUE_ESQUERDA
				flip_h = false
				direita = false
				impacto_esquerda.show()
			3:
				inimigo.texture = INIMIGO_ATAQUE_DIREITA
				flip_h = true
				direita = true
				impacto_direita.show()
	else:
		match direction:
			0:
				texture = PLAYER_ATAQUE_ESQUERDA
				inimigo.flip_h = false
				direita = false
				impacto_esquerda.show()
			1:
				texture = PLAYER_ATAQUE_DIREITA
				inimigo.flip_h = true
				direita = true
				impacto_direita.show()
			2:
				texture = PLAYER_ATAQUE_ESQUERDA
				inimigo.flip_h = false
				direita = false
				impacto_esquerda.show()
			3:
				texture = PLAYER_ATAQUE_DIREITA
				inimigo.flip_h = true
				direita = true
				impacto_direita.show()
	
	if !hit:
		modulate = Color.RED
	
	reset_sprites.start()

func resetSprites():
	modulate = Color.WHITE
	texture = PLAYER_DEFESA
	inimigo.texture = INIMIGO_NEUTRO
	flip_h = false
	if direita:
		flip_h = true
		inimigo.flip_h = true
	else:
		flip_h = false
		inimigo.flip_h = false
	impacto_esquerda.hide()
	impacto_direita.hide()

func change_state():
	pass

func set_sprite():
	pass




func _on_reset_sprites_timeout() -> void:
	resetSprites()
