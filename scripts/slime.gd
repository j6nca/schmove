extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2.ZERO
const BASE_MAX_CHARGES = 2
const BASE_THROW_SPEED = 50
const BASE_TIME_TO_DETONATE = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = BASE_THROW_SPEED * velocity # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_collide(velocity * delta)
	
func detonate(target_position):
	pass
