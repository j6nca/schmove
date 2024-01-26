extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_trajectory(dir: Vector2, speed: float, delta):
	var max_points = 50
	clear_points()
	var pos: Vector2 = Vector2.ZERO
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
