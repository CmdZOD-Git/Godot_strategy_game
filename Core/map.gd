extends Node

@export var baseTile:PackedScene
@export var HorizontalRepeat:int = 20
@export var VerticalRepeat:int = 9
@export var TileSize:int = 64

var allTiles:Array[Tile] = []
var tilesWithBuildings:Array[Tile] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in HorizontalRepeat:
		for y in VerticalRepeat:
			var tileToAdd:Tile = baseTile.instantiate()
			var h:int = TileSize / 2 + x * TileSize
			var v:int = TileSize / 2 + y * TileSize
			tileToAdd.global_position = Vector2(h,v)
			tileToAdd.grid_position = Vector2(x, y)
			allTiles.append(tileToAdd)
			add_child.call_deferred(tileToAdd)
			tileToAdd.add_to_group("Tiles")
	
	var startingTile:Tile = allTiles.pick_random()
	startingTile.startTile = true
	startingTile.hasBuilding = true
	tilesWithBuildings.append(startingTile)
	
	await get_tree().process_frame
	
	highlight_available_tiles()

func is_tile_at_position(position:Vector2) -> bool:
	for tile:Tile in allTiles:
		if tile.grid_position == position:
			return true
	return false

func get_tile_at_position(position:Vector2):
	for tile:Tile in allTiles:
		if tile.grid_position == position:
			return tile
	return null

func is_tile_free(tile:Tile) -> bool:
	return not tile.hasBuilding
	
func disable_highlight_all_tile() -> void:
	for tile:Tile in allTiles:
		tile.set_highlight(false)

func highlight_available_tiles() -> void:
	var grid_4_directions:Array[Vector2] = [
		Vector2(0,1),
		Vector2(1,0),
		Vector2(0,-1),
		Vector2(-1,0),
	]
	
	var check_4_directions:Callable = func (tile:Tile) -> Array[Tile]:
		var return_buffer:Array[Tile] = []
		
		for direction:Vector2 in grid_4_directions:
			var grid_position_tested:Vector2 = tile.grid_position + direction
			if is_tile_at_position(grid_position_tested) == false:
				continue
				
			var tile_tested = get_tile_at_position(grid_position_tested)
			if is_tile_free(tile_tested) == true:
				return_buffer.append(tile)
		return return_buffer
	
	var intermediate_array:Array[Tile] = []
	
	for tile:Tile in tilesWithBuildings:
		intermediate_array.append_array(check_4_directions.call(tile))
	
	for tile:Tile in intermediate_array:
		tile.set_highlight(true)
