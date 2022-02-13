extends TileMap

export var breakable_tile: PackedScene

onready var half_cell_size := cell_size * 0.5

func _ready():
	for tile_pos in get_used_cells():
		var tile_id = get_cell(tile_pos.x, tile_pos.y)
		
		if tile_id == 2:
			if get_cellv(tile_pos) != INVALID_CELL:
				set_cellv(tile_pos, -1)
				update_bitmask_region()
			
			# Spawn the object
			if breakable_tile:
				var obj = breakable_tile.instance()
				var ob_pos = map_to_world(tile_pos) + half_cell_size
				
				get_parent().call_deferred("add_child", obj)
				obj.global_position = ob_pos
