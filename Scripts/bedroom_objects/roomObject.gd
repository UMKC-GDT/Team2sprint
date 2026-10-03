extends Sprite2D

@export var object_dialogue: Array[String] 
@export var key_item: Sprite2D
@export var mini_game: String


func _ready() -> void:
	var area = get_child(0)
	area.mouse_entered.connect(on_mouse_entered)
	area.mouse_exited.connect(on_mouse_exited)
	area.input_event.connect(on_clicked)

var mouse_on = false

func on_mouse_entered() -> void:
	mouse_on = true
	self.scale = Vector2(1.05,1.05)

func on_mouse_exited() -> void:
	mouse_on = false
	self.scale = Vector2(1,1)
	

func on_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if mouse clicks the rug
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		SignalBus.object_clicked.emit(object_dialogue,mini_game, key_item)
		print("clicked")
