extends Area2D

var tiles = []
var solved = []
var mouse = false

const GRID_SIZE = 3
const TILE_SIZE = 333.333333

func _ready():
	start_game()

func start_game():
	tiles = [
		$Tile1,
		$Tile2,
		$Tile3,
		$Tile4,
		$Tile5,
		$Tile6,
		$Tile7,
		$Tile8,
		$Tile9
	]

	solved = tiles.duplicate()
	shuffle_tiles()


func shuffle_tiles():
	var previous = 99
	var previous_1 = 98

	for t in range(0, 1000):
		var tile = randi() % 9

		if tiles[tile] != $Tile9 and tile != previous and tile != previous_1:
			var rows = int(tiles[tile].position.y / TILE_SIZE)
			var cols = int(tiles[tile].position.x / TILE_SIZE)

			check_neighbours(rows, cols)

			previous_1 = previous
			previous = tile


func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse:
		var mouse_copy = mouse
		mouse = false

		var rows = int(mouse_copy.position.y / TILE_SIZE)
		var cols = int(mouse_copy.position.x / TILE_SIZE)

		check_neighbours(rows, cols)

		if tiles == solved:
			print("You win!")


func check_neighbours(rows, cols):
	var empty = false
	var done = false

	var pos = rows * GRID_SIZE + cols

	while !empty and !done:
		var new_pos = tiles[pos].position

		# Down
		if rows < GRID_SIZE - 1:
			new_pos.y += TILE_SIZE
			empty = find_empty(new_pos, pos)
			new_pos.y -= TILE_SIZE

		# Up
		if rows > 0 and !empty:
			new_pos.y -= TILE_SIZE
			empty = find_empty(new_pos, pos)
			new_pos.y += TILE_SIZE

		# Right
		if cols < GRID_SIZE - 1 and !empty:
			new_pos.x += TILE_SIZE
			empty = find_empty(new_pos, pos)
			new_pos.x -= TILE_SIZE

		# Left
		if cols > 0 and !empty:
			new_pos.x -= TILE_SIZE
			empty = find_empty(new_pos, pos)
			new_pos.x += TILE_SIZE

		done = true


func find_empty(position, pos):
	var new_rows = int(position.y / TILE_SIZE)
	var new_cols = int(position.x / TILE_SIZE)

	var new_pos = new_rows * GRID_SIZE + new_cols

	if tiles[new_pos] == $Tile9:
		swap_tiles(pos, new_pos)
		return true

	return false


func swap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position

	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos

	var temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = temp_tile


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		mouse = event
