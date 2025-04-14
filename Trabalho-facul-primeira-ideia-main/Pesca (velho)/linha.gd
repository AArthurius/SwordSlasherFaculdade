extends Line2D

@onready var mark_barco: Marker2D = $"../Barco/Mark Barco"
@onready var mark_anzol: Marker2D = $"../Anzol/Mark Anzol"


func _process(delta: float) -> void:
	points = [mark_barco.global_position, mark_anzol.global_position]
