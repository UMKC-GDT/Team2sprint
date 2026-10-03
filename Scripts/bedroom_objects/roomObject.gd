extends Sprite2D


func _ready() -> void:
	var area = get_child(0)
	area.mouse_entered.connect(on_mouse_entered)
	area.mouse_exited.connect(on_mouse_exited)


var mouse_on = false

func on_mouse_entered() -> void:
	mouse_on = true
	self.scale = Vector2(1.05,1.05)

func on_mouse_exited() -> void:
	mouse_on = false
	self.scale = Vector2(1,1)
