extends RigidBody2D

@onready var detonate_timer : Timer = $Self_Detonate_Timer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2.ZERO
const BASE_MAX_CHARGES = 2
const BASE_THROW_SPEED = 150
const BASE_TIME_TO_DETONATE = 3

func _ready():
	velocity = BASE_THROW_SPEED * velocity
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	detonate_timer.wait_time = BASE_TIME_TO_DETONATE
	detonate_timer.start()

func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_collide(velocity * delta)
	
func detonate():
	#detonate logic here
	queue_free()

func _on_self_detonate_timer_timeout():
	detonate()
