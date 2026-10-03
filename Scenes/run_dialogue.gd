extends RichTextLabel

#keeps track of current running text
var dialogue_lines : Array
var letter = 0
var line = 0
var running_dialogue = false


@onready var textbox: ColorRect = get_parent()

#signals to the manager when it can move to next script line

signal dialogue_done 

func _process(_delta):
	#if there's no dialogue, show nothing
	if dialogue_lines == null or running_dialogue == false:
		var tween = create_tween()
		tween.tween_property(textbox, "scale", Vector2(1,0), .15)

		self.text = ""
	
	#if dialogue line is still running, add another letter each frame
	elif line < dialogue_lines.size() and letter < dialogue_lines[line].length():
		var tween = create_tween()
		tween.tween_property(textbox, "scale", Vector2(1,1), .15)
		
		self.text += dialogue_lines[line][letter]
		letter += 1	
		
	#if the line is not running anymore and player clicks mouse, move to next line
	elif (Input.is_action_just_pressed("click") ):
		line +=1
		letter = 0
		self.text = ""
	
	#if all the dialogue lines have finished 
	elif line == dialogue_lines.size():
		self.text = ""
		letter = 0
		line = 0
		dialogue_done.emit() #sends signal to Dialogue Box
		
func set_lines(i: Array):
	dialogue_lines = i
	

func set_running(setting: bool):
	running_dialogue = setting
