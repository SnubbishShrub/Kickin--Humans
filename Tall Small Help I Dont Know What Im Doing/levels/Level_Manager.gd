extends Control



func _ready():
	for n in $Control.get_children():
		if n.name in LevelState.unlocked:
			n.disabled = false
			n.connect("pressed", self, "change", [n.name, get_node("Control/" + n.name).get_global_position()])
		else:
			n.disabled = true
			
	$Sprite.set_frame(LevelState.unlocked.size() - 1)

func change(level, pos):
	pos[0] += 30
	pos[1] += 30
	var scene = "res://levels/Level_" + level + ".tscn"
	SceneChange.scene_change(scene, pos)

