extends Sprite2D


var mouse_on = false

func _on_area_2d_mouse_entered() -> void:
	mouse_on = true

func _on_area_2d_mouse_exited() -> void:
	mouse_on = false
