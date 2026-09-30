extends ColorRect

@onready var textBox: RichTextLabel = get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false 
	
#objects in the room call this function 
#the dialogue text is stored on the object itself
func trigger_dialogue(text: Array):
	textBox.set_lines(text)
	textBox.set_running(true)
	
#ends the dialogue box
func _on_dialogue_done() -> void:
	textBox.set_running(false)
