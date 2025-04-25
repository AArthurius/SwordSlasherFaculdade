extends TextureRect

@onready var lista_de_comandos: Control = $"../Área vísivel da lista/Lista de Comandos"

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
