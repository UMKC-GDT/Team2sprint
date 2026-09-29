extends Sprite2D

@export var highlight_texture:Texture2D

@onready var main_texture:Texture2D = self.texture

var mouse_on = false

func _on_area_2d_mouse_entered() -> void:
	mouse_on = true
	self.texture = highlight_texture

func _on_area_2d_mouse_exited() -> void:
	mouse_on = false
	self.texture = main_texture

	
