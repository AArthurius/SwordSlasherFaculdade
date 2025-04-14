extends TextureRect


const FLECHAH = preload("res://Assets/flechah.png")
const FLECHAV = preload("res://Assets/flechav.png")

@export var direction = 0

func _ready() -> void:
	pivot_offset.x = size.x/2
	anchor_top = 0.5
	match direction:
		0: #left
			texture = FLECHAH
			flip_h = true
		1: #right
			texture = FLECHAH
			flip_h = false
		2: #up
			texture = FLECHAV
			flip_h = false
		3: #down
			texture = FLECHAV
			flip_v = true
