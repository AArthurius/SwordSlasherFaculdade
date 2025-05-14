extends Control

@onready var inimigo: Sprite2D = $"../Inimigo"
@onready var player: Sprite2D = $Player
@onready var reset_sprites: Timer = $"../Reset sprites"
@onready var impacto_esquerda: TextureRect = $"../impacto esquerda"
@onready var impacto_direita: TextureRect = $"../impacto direita"

#const SPRITESHEET_INIMIGO = preload("res://Assets/S/spritesheet inimigo.png")
#const SPRITESHEET_PLAYER = preload("res://Assets/S/spritesheet player.png")

var sheetX = 625
var sheetY = 0
var sheetWidth = 625
var sheetHeight = 822
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
	spriteID = attackDirection
	setSprite(enemyAttack)
	if !hit:
		modulate = Color.RED

func _on_reset_sprites_timeout() -> void:
	modulate = Color.WHITE
	if spriteID in [0, 2]:
		player.region_rect = Rect2(sheetX * 0, sheetY, sheetWidth, sheetHeight)
		inimigo.region_rect = Rect2(sheetX * 0, sheetY, sheetWidth, sheetHeight)
	else:
		player.region_rect = Rect2(sheetX * 1, sheetY, sheetWidth, sheetHeight)
		inimigo.region_rect = Rect2(sheetX * 1, sheetY, sheetWidth, sheetHeight)
	impacto_esquerda.hide()
	impacto_direita.hide()

func setSprite(enemyAttack):
	if enemyAttack:
		inimigo.region_rect = Rect2(sheetX * spriteID, sheetY, sheetWidth, sheetHeight)
	else:
		player.region_rect = Rect2(sheetX * spriteID, sheetY, sheetWidth, sheetHeight)
	
	#mostrar impacto
	if spriteID in [0, 2]:
		impacto_esquerda.show()
	elif spriteID in [1, 3]:
		impacto_direita.show()
	
	reset_sprites.start()

func setFrame(ID) -> Rect2:
		return Rect2(sheetX * ID, sheetY, sheetWidth, sheetHeight)
